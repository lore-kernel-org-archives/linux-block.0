Return-Path: <roman.penyaev@profitbricks.com>
Return-Path: <roman.penyaev@profitbricks.com>
From: Roman Pen <roman.penyaev@profitbricks.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Swapnil Ingle <swapnil.ingle@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>,
	Roman Pen <roman.penyaev@profitbricks.com>
Subject: [PATCH v2 00/26] InfiniBand Transport (IBTRS) and Network Block Device (IBNBD)
Date: Fri, 18 May 2018 15:03:47 +0200
Message-Id: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Hi all,

This is v2 of series, which introduces IBNBD/IBTRS modules.

This cover letter is split on three parts:

1. Introduction, which almost repeats everything from previous cover
   letters.
2. Changelog.
3. Performance measurements on linux-4.17.0-rc2 and on two different
   Mellanox cards: ConnectX-2 and ConnectX-3 and CPUs: Intel and AMD.


 Introduction
 -------------

IBTRS (InfiniBand Transport) is a reliable high speed transport library
which allows for establishing connection between client and server
machines via RDMA. It is optimized to transfer (read/write) IO blocks
in the sense that it follows the BIO semantics of providing the
possibility to either write data from a scatter-gather list to the
remote side or to request ("read") data transfer from the remote side
into a given set of buffers.

IBTRS is multipath capalbdke and provides I/O fail-over and load-balancing
functionality, i.e. in IBTRS terminology, an IBTRS path is a set of RDMA
CMs and particular path is selected according to the load-balancing policy.

IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
(client and server) that allow for remote access of a block device on
the server over IBTRS protocol. After being mapped, the remote block
devices can be accessed on the client side as local block devices.
Internally IBNBD uses IBTRS as an RDMA transport library.

Why?

   - IBNBD/IBTRS is developed in order to map thin provisioned volumes,
     thus internal protocol is simple.
   - IBTRS was developed as an independent RDMA transport library, which
     supports fail-over and load-balancing policies using multipath, thus
     it can be used for any other IO needs rather than only for block
     device.
   - IBNBD/IBTRS is faster than NVME over RDMA.
     Old comparison results:
     https://www.spinics.net/lists/linux-rdma/msg48799.html
     New comparison results: see performance measurements section below.

Key features of IBTRS transport library and IBNBD block device:

o High throughput and low latency due to:
   - Only two RDMA messages per IO.
   - IMM InfiniBand messages on responses to reduce round trip latency.
   - Simplified memory management: memory allocation happens once on
     server side when IBTRS session is established.

o IO fail-over and load-balancing by using multipath.  According to
  our test loads additional path brings ~20% of bandwidth.  

o Simple configuration of IBNBD:
   - Server side is completely passive: volumes do not need to be
     explicitly exported.
   - Only IB port GID and device path needed on client side to map
     a block device.
   - A device is remapped automatically i.e. after storage reboot.

Commits for kernel can be found here:
   https://github.com/profitbricks/ibnbd/commits/linux-4.17-rc2

The out-of-tree modules are here:
   https://github.com/profitbricks/ibnbd/

Vault 2017 presentation:
   http://events.linuxfoundation.org/sites/events/files/slides/IBNBD-Vault-2017.pdf


 Changelog
 ---------

v2:
  o IBNBD:
     - No legacy request IO mode, only MQ is left.

  o IBTRS:
     - No FMR registration, only FR is left.

     - By default memory is always registered for the sake of the security,
	   i.e. by default no pd is created with IB_PD_UNSAFE_GLOBAL_RKEY.

	 - Server side (target) always does memory registration and exchanges
	   MRs dma addresses with client for direct writes from client side.

	 - Client side (initiator) has `noreg_cnt` module option, which specifies
	   sg number, from which read IO should be registered.  By default 0
	   is set, i.e. always register memory for read IOs. (IBTRS protocol
	   does not require registration for writes, which always go directly
	   to server memory).

	 - Proper DMA sync with ib_dma_sync_single_for_(cpu|device) calls.

     - Do signalled IB_WR_LOCAL_INV.

	 - Avoid open-coding of string conversion to IPv4/6 sockaddr,
	   inet_pton_with_scope() is used instead.

     - Introduced block device namespaces configuration on server side
	   (target) to avoid security gap in not trusted environment, when
	   client can map a block device which does not belong to him.
	   When device namespaces are enabled on server side, server opens
	   device using client's session name in the device path, where
	   session name is a random token, e.g. GUID.  If server is configured
	   to find device namespaces in a folder /run/ibnbd-guid/, then
	   request to map device 'sda1' from client with session 'A' (or any
	   token) will be resolved by path /run/ibnbd-guid/A/sda1.

     - README is extended with description of IBTRS and IBNBD protocol,
	   e.g. how IB IMM field is used to acknowledge IO requests or
	   heartbeats.

     - IBTRS/IBNBD client and server modules are registered as devices in
	   the kernel in order to have all sysfs configuration entries under
	   /sys/devices/virtual/ in order not to spoil /sys/kernel directory.
	   I failed to switch configuration to configfs, because of the
	   several reasons:

	   a) configfs entries created from kernel side using
	      configfs_register_group() API call can't be removed from
		  userspace side using rmdir() syscall.  That is required
		  behaviour for IBTRS when session is created by API call and
		  not from userspace.
			   
          Actually, I have a patch for configfs to solve a), but then
		  b) comes.

       b) configfs show/store callbacks are racy by design (in
	      contradiction to kernfs), i.e. even dentry is unhashed, opener
		  of it can be faster and in few moments later those callbacks
		  can be invoked.  To guarantee that all openers left and nobody
		  is able to access an entry after configfs_drop_dentry() is
		  returned additional hairy code should be written with wait
		  queues, locks, etc.  I didn't like at all what I eventually
		  got, gave up and left as is, i.e. sysfs.
			    

  What is left unchanged on IBTRS side but was suggested to modify:

     - Bart suggested to use sbitmap instead of calling find_first_zero_bit()
	   and friends.  I found calling pure bit API is more explicit in
	   comparison to sbitmap - there is no need in using sbitmap_queue
	   and all the power of wait queues, no benefits in terms of LoC
	   as well.
	   
     - I did several attempts to unify approach of wrapping ib_device
	   with ULP device structure (e.g. device pool or using ib_client
	   API) but it turns out to be that none of these approaches bring
	   simplicity, so IBTRS still creates ULP specific device on demand
	   and keeps it in the list.

     - Sagi suggested to extend inet_pton_with_scope() with gid to
	   sockaddr conversion, but after IPv6 conversion (gid is compliant
	   with IPv6) special RDMA magic should be done in order to setup
	   IB port space range, which is very specific and does not fit to
	   be some generic library helper.  And am I right that gid is not
	   used and seems dying?


v1:
  - IBTRS: load-balancing and IO fail-over using multipath features were added.

  - Major parts of the code were rewritten, simplified and overall code
    size was reduced by a quarter.

  * https://lwn.net/Articles/746342/

v0:
  - Initial submission

  * https://lwn.net/Articles/718181/


 Performance measurements
 ------------------------

o FR and FMR:

  Firstly I would like to start performance measurements with (probably
  well known) observations that FR is slower than FMR by ~40% on Mellanox
  ConnectX-2 and by ~15% on ConnectX-3. That is a huge numbers, e.g. FIO
  results on IBNBD:

  - on ConnectX-2 (MT26428)
    x64 CPUs AMD Opteron(tm) Processor 6282 SE

     rw=randread, bandwidth in Kbytes:
     jobs   IBNBD (FMR)   IBNBD (FR)     Change
       x1       1037624       932951     -10.1%
       x8       2569649       1543074    -40.0%
      x16       2751461       1531282    -44.3%
      x24       2360887       1396153    -40.9%
      x32       1873174       1215334    -35.1%
      x40       1995846       1255781    -37.1%
      x48       2004740       1240931    -38.1%
      x56       2076871       1250333    -39.8%
      x64       2051668       1229389    -40.1%

  - on ConnectX-3 (MT4099)
    x40 CPUs Intel(R) Xeon(R) CPU E5-2660 v3 @ 2.60GHz

     rw=randread, bandwidth in Kbytes:
     jobs   IBNBD (FMR)   IBNBD (FR)     Change
       x1       2243322       1961216    -12.6%
       x8       4389048       4012912     -8.6%
      x16       4473103       4033837     -9.8%
      x24       4570209       3939186    -13.8%
      x32       4576757       3843434    -16.0%
      x40       4468110       3696896    -17.3%
      x48       4848049       4106259    -15.3%
      x56       4872790       4141374    -15.0%
      x64       4967287       4207317    -15.3%

  I missed the whole history why FMR is considered as outdated, why FMR
  is a no way, I would very much appreciate if someone would explain me
  why FR should be prefered. Is there a link with a clear explanation?

o IBNBD and NVMEoRDMA

  Here I would like to publish IBNBD and NVMEoRDMA comparison results
  with FR memory registration on each IO (i.e. with the following modules
  params: 'register_always=Y' for NVME and 'noreg_cnt=0' for IBTRS).

  - on ConnectX-2 (MT26428)
    x64 CPUs AMD Opteron(tm) Processor 6282 SE

     rw=randread, bandwidth in Kbytes:
     jobs        IBNBD     NVMEoRDMA     Change
       x1       932951        975425      +4.6%
       x8      1543074       1504416      -2.5%
      x16      1531282       1432937      -6.4%
      x24      1396153       1244858     -10.8%
      x32      1215334       1066607     -12.2%
      x40      1255781       1076841     -14.2%
      x48      1240931       1066453     -14.1%
      x56      1250333       1065879     -14.8%
      x64      1229389       1064199     -13.4%

     rw=randwrite, bandwidth in Kbytes:
     jobs        IBNBD     NVMEoRDMA     Change
       x1       1416413      1181102     -16.6%
       x8       2438615      1977051     -18.9%
      x16       2436924      1854223     -23.9%
      x24       2430527      1714580     -29.5%
      x32       2425552      1641288     -32.3%
      x40       2378784      1592788     -33.0%
      x48       2202260      1511895     -31.3%
      x56       2207013      1493400     -32.3%
      x64       2098949      1432951     -31.7%


  - on ConnectX-3 (MT4099)
    x40 CPUs Intel(R) Xeon(R) CPU E5-2660 v3 @ 2.60GHz

     rw=randread, bandwidth in Kbytes:
     jobs        IBNBD     NVMEoRDMA     Change
       x1      1961216       2046572      +4.4%
       x8      4012912       4059410      +1.2%
      x16      4033837       3968410      -1.6%
      x24      3939186       3770729      -4.3%
      x32      3843434       3623869      -5.7%
      x40      3696896       3448772      -6.7%
      x48      4106259       3729201      -9.2%
      x56      4141374       3732954      -9.9%
      x64      4207317       3805638      -9.5%

     rw=randwrite, bandwidth in Kbytes:
     jobs        IBNBD     NVMEoRDMA     Change
       x1      3195637       2479068     -22.4%
       x8      4576924       4541743      -0.8%
      x16      4581528       4555459      -0.6%
      x24      4692540       4595963      -2.1%
      x32      4686968       4540456      -3.1%
      x40      4583814       4404859      -3.9%
      x48      4969587       4710902      -5.2%
      x56      4996101       4701814      -5.9%
      x64      5083460       4759663      -6.4%

  The interesting observation is that on machine with Intel CPUs and
  ConnectX-3 card the difference between IBNBD and NVME bandwidth is
  significantly smaller comparing to AMD and ConnectX-2.  I did not
  thoroughly investiage that behaviour, but suspect that the devil
  is in Intel vs AMD architecture and probably how NUMAs are organized,
  i.e. Intel has 2 NUMA nodes against 8 on AMD.  If someone is interested
  in those results and can point me out where to dig on NVME side I can
  investigate deeply why exactly NVME bandwidth significantly drops on
  AMD machine with Connect-X2.

  Shiny graphs are here:
  https://docs.google.com/spreadsheets/d/1vxSoIvfjPbOWD61XMeN2_gPGxsxrbIUOZADk1UX5lj0

Roman Pen (26):
  rculist: introduce list_next_or_null_rr_rcu()
  sysfs: export sysfs_remove_file_self()
  ibtrs: public interface header to establish RDMA connections
  ibtrs: private headers with IBTRS protocol structs and helpers
  ibtrs: core: lib functions shared between client and server modules
  ibtrs: client: private header with client structs and functions
  ibtrs: client: main functionality
  ibtrs: client: statistics functions
  ibtrs: client: sysfs interface functions
  ibtrs: server: private header with server structs and functions
  ibtrs: server: main functionality
  ibtrs: server: statistics functions
  ibtrs: server: sysfs interface functions
  ibtrs: include client and server modules into kernel compilation
  ibtrs: a bit of documentation
  ibnbd: private headers with IBNBD protocol structs and helpers
  ibnbd: client: private header with client structs and functions
  ibnbd: client: main functionality
  ibnbd: client: sysfs interface functions
  ibnbd: server: private header with server structs and functions
  ibnbd: server: main functionality
  ibnbd: server: functionality for IO submission to file or block dev
  ibnbd: server: sysfs interface functions
  ibnbd: include client and server modules into kernel compilation
  ibnbd: a bit of documentation
  MAINTAINERS: Add maintainer for IBNBD/IBTRS modules

 MAINTAINERS                                    |   14 +
 drivers/block/Kconfig                          |    2 +
 drivers/block/Makefile                         |    1 +
 drivers/block/ibnbd/Kconfig                    |   22 +
 drivers/block/ibnbd/Makefile                   |   13 +
 drivers/block/ibnbd/README                     |  299 +++
 drivers/block/ibnbd/ibnbd-clt-sysfs.c          |  669 ++++++
 drivers/block/ibnbd/ibnbd-clt.c                | 1818 +++++++++++++++
 drivers/block/ibnbd/ibnbd-clt.h                |  171 ++
 drivers/block/ibnbd/ibnbd-log.h                |   71 +
 drivers/block/ibnbd/ibnbd-proto.h              |  364 +++
 drivers/block/ibnbd/ibnbd-srv-dev.c            |  410 ++++
 drivers/block/ibnbd/ibnbd-srv-dev.h            |  149 ++
 drivers/block/ibnbd/ibnbd-srv-sysfs.c          |  242 ++
 drivers/block/ibnbd/ibnbd-srv.c                |  922 ++++++++
 drivers/block/ibnbd/ibnbd-srv.h                |  100 +
 drivers/infiniband/Kconfig                     |    1 +
 drivers/infiniband/ulp/Makefile                |    1 +
 drivers/infiniband/ulp/ibtrs/Kconfig           |   20 +
 drivers/infiniband/ulp/ibtrs/Makefile          |   15 +
 drivers/infiniband/ulp/ibtrs/README            |  358 +++
 drivers/infiniband/ulp/ibtrs/ibtrs-clt-stats.c |  455 ++++
 drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c |  482 ++++
 drivers/infiniband/ulp/ibtrs/ibtrs-clt.c       | 2814 ++++++++++++++++++++++++
 drivers/infiniband/ulp/ibtrs/ibtrs-clt.h       |  304 +++
 drivers/infiniband/ulp/ibtrs/ibtrs-log.h       |   91 +
 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h       |  458 ++++
 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c |  110 +
 drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c |  271 +++
 drivers/infiniband/ulp/ibtrs/ibtrs-srv.c       | 1980 +++++++++++++++++
 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h       |  174 ++
 drivers/infiniband/ulp/ibtrs/ibtrs.c           |  609 +++++
 drivers/infiniband/ulp/ibtrs/ibtrs.h           |  331 +++
 fs/sysfs/file.c                                |    1 +
 include/linux/rculist.h                        |   19 +
 35 files changed, 13761 insertions(+)
 create mode 100644 drivers/block/ibnbd/Kconfig
 create mode 100644 drivers/block/ibnbd/Makefile
 create mode 100644 drivers/block/ibnbd/README
 create mode 100644 drivers/block/ibnbd/ibnbd-clt-sysfs.c
 create mode 100644 drivers/block/ibnbd/ibnbd-clt.c
 create mode 100644 drivers/block/ibnbd/ibnbd-clt.h
 create mode 100644 drivers/block/ibnbd/ibnbd-log.h
 create mode 100644 drivers/block/ibnbd/ibnbd-proto.h
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.h
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-sysfs.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
 create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile
 create mode 100644 drivers/infiniband/ulp/ibtrs/README
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-stats.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-log.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.h

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Danil Kipnis <danil.kipnis@profitbricks.com>
Cc: Jack Wang <jinpu.wang@profitbricks.com>

-- 
2.13.1
