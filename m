Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 23:47:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
	"loberman@redhat.com" <loberman@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171103154700.GA7021@ming.t460p>
References: <1509666235.2484.23.camel@wdc.com>
 <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com>
 <20171103001541.GF27370@ming.t460p>
 <1509670091.2636.0.camel@wdc.com>
 <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
 <20171103021234.GH27370@ming.t460p>
 <1509676969.10883.0.camel@wdc.com>
 <20171103035050.GI27370@ming.t460p>
 <1509722593.2473.12.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509722593.2473.12.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 03, 2017 at 03:23:14PM +0000, Bart Van Assche wrote:
> On Fri, 2017-11-03 at 11:50 +0800, Ming Lei wrote:
> > On Fri, Nov 03, 2017 at 02:42:50AM +0000, Bart Van Assche wrote:
> > > On Fri, 2017-11-03 at 10:12 +0800, Ming Lei wrote:
> > > > [root@ibclient srp-test]# ./run_tests
> > > > modprobe: FATAL: Module target_core_mod is in use.
> > > 
> > > LIO must be unloaded before srp-test software is started.
> > 
> > Yeah, I can make this test kick off after running
> > 'modprobe -fr ib_isert' first, but looks all tests failed without
> > any hang, could you check if that is the expected result?
> > 
> > 	https://pastebin.com/VXe66Jpg
> 
> I see plenty of "... >/sys/.../add_target failed: Connection timed out"
> messages. The srp-test scripts use the loopback functionality of IB ports
> so one or more IB ports must be active. Have you already checked the IB
> ports state, e.g. by running ibv_devinfo?

[root@ibclient ~]# ibv_devinfo
hca_id:	mlx5_1
	transport:			InfiniBand (0)
	fw_ver:				12.20.1010
	node_guid:			7cfe:9003:0072:6ed3
	sys_image_guid:			7cfe:9003:0072:6ed2
	vendor_id:			0x02c9
	vendor_part_id:			4115
	hw_ver:				0x0
	board_id:			MT_2190110032
	phys_port_cnt:			1
		port:	1
			state:			PORT_ACTIVE (4)
			max_mtu:		4096 (5)
			active_mtu:		4096 (5)
			sm_lid:			1
			port_lid:		1
			port_lmc:		0x00
			link_layer:		InfiniBand

hca_id:	mlx5_0
	transport:			InfiniBand (0)
	fw_ver:				12.20.1010
	node_guid:			7cfe:9003:0072:6ed2
	sys_image_guid:			7cfe:9003:0072:6ed2
	vendor_id:			0x02c9
	vendor_part_id:			4115
	hw_ver:				0x0
	board_id:			MT_2190110032
	phys_port_cnt:			1
		port:	1
			state:			PORT_ACTIVE (4)
			max_mtu:		4096 (5)
			active_mtu:		4096 (5)
			sm_lid:			4
			port_lid:		4
			port_lmc:		0x00
			link_layer:		InfiniBand

Forget to mention, there is failure when running 'make' under srp-test
because shellcheck package is missed in RHEL7. Can that be the issue
of test failure? If yes, could you provide a special version of srp-test
which doesn't depend on shellcheck?

> 
> > Also could you provide some output from debugfs when this hang happens?
> > such as:
> > 
> > 	dispatch/busy/.. under hctxN
> 
> This is the output that appears on my test setup if the two patches from
> the patch series "block: remove unnecessary RESTART" are applied:
> 
> # ~bart/software/infiniband/srp-test/run_tests -f xfs -d -e deadline -r 60                             
> Unloaded the ib_srpt kernel module
> Zero-initializing /dev/ram0 ... done
> Zero-initializing /dev/ram1 ... done
> Zero-initializing /dev/disk/by-id/scsi-33333333000004650 ... done
> brw-rw---- 1 root disk 1, 0 Nov  3 08:10 /dev/ram0
> /dev/ram0
> brw-rw---- 1 root disk 1, 1 Nov  3 08:10 /dev/ram1
> /dev/ram1
> lrwxrwxrwx 1 root root 9 Nov  3 08:11 /dev/disk/by-id/scsi-33333333000004650 -> ../../sdi
> /dev/sdi
> Configured SRP target driver
> Running test /home/bart/software/infiniband/srp-test/tests/01 ...
> id_ext=0x0002c90300a02d50,ioc_guid=0x0002c90300a02d50,dgid=fe800000000000000002c90300a02d51,pkey=7fff,service_id=0x0002c90300a02d50, >/sys/class/infiniband_srp/
> srp-mlx4_0-2/add_target failed: Invalid argument
> id_ext=0x0002c90300a02d50,ioc_guid=0x0002c90300a02d50,dgid=fe800000000000000002c90300a02d52,pkey=7fff,service_id=0x0002c90300a02d50, >/sys/class/infiniband_srp/
> srp-mlx4_0-2/add_target failed: Invalid argument
> count_luns(): 3 <> 3
> Error: unloading kernel module ib_srp failed
> Test /home/bart/software/infiniband/srp-test/tests/01 failed
> # cat /sys/module/scsi_mod/parameters/use_blk_mq  
> Y
> # find /sys/kernel/debug/block -name busy | xargs cat

Can you check 'dispatch' file, hctx state, tags and sched_tags?
And see where is the IO not dispatched?

> # dmesg -c >/dev/null; echo w > /proc/sysrq-trigger; dmesg
> [  709.321750] sysrq: SysRq : Show Blocked State
> [  709.327906]   task                        PC stack   pid father
...
> [  709.456602] kworker/u66:6   D    0   341      2 0x80000000
> [  709.463371] Workqueue: events_unbound async_run_entry_fn
> [  709.469919] Call Trace:
> [  709.473325]  __schedule+0x2fa/0xbb0
> [  709.477850]  ? trace_hardirqs_on_caller+0xfb/0x190
> [  709.483847]  schedule+0x36/0x90
> [  709.487982]  schedule_timeout+0x22c/0x570
> [  709.493115]  ? call_timer_fn+0x330/0x330
> [  709.498133]  ? wait_for_completion_io_timeout+0xf7/0x180
> [  709.504732]  io_schedule_timeout+0x1e/0x50
> [  709.509938]  ? io_schedule_timeout+0x1e/0x50
> [  709.515413]  wait_for_completion_io_timeout+0x11f/0x180
> [  709.521920]  ? wake_up_q+0x80/0x80
> [  709.526376]  blk_execute_rq+0x86/0xc0
> [  709.531135]  scsi_execute+0xdb/0x1f0
> [  709.536336]  sd_revalidate_disk+0xed/0x1c70 [sd_mod]
> [  709.543281]  sd_probe_async+0xc3/0x1d0 [sd_mod]
> [  709.549524]  async_run_entry_fn+0x38/0x160
> [  709.555503]  process_one_work+0x20a/0x660
> [  709.561299]  worker_thread+0x3d/0x3b0
> [  709.566688]  kthread+0x13a/0x150
> [  709.571613]  ? process_one_work+0x660/0x660
> [  709.577561]  ? kthread_create_on_node+0x40/0x40
> [  709.583910]  ret_from_fork+0x27/0x40

Looks hang in scsi_execute().

> [  709.589174] kworker/5:2     D    0   386      2 0x80000000
> [  709.596616] Workqueue: kaluad alua_rtpg_work [scsi_dh_alua]
> [  709.604130] Call Trace:
> [  709.608096]  __schedule+0x2fa/0xbb0
> [  709.613265]  ? trace_hardirqs_on_caller+0xfb/0x190
> [  709.619879]  schedule+0x36/0x90
> [  709.624684]  schedule_timeout+0x22c/0x570
> [  709.630437]  ? call_timer_fn+0x330/0x330
> [  709.636059]  ? wait_for_completion_io_timeout+0xf7/0x180
> [  709.643270]  io_schedule_timeout+0x1e/0x50
> [  709.649083]  ? io_schedule_timeout+0x1e/0x50
> [  709.655159]  wait_for_completion_io_timeout+0x11f/0x180
> [  709.662284]  ? wake_up_q+0x80/0x80
> [  709.667334]  blk_execute_rq+0x86/0xc0
> [  709.672705]  scsi_execute+0xdb/0x1f0
> [  709.677938]  alua_rtpg_work+0x2b3/0xe8a [scsi_dh_alua]
> [  709.684983]  process_one_work+0x20a/0x660
> [  709.690759]  worker_thread+0x3d/0x3b0
> [  709.696107]  kthread+0x13a/0x150
> [  709.700986]  ? process_one_work+0x660/0x660
> [  709.706920]  ? kthread_create_on_node+0x40/0x40
> [  709.713316]  ret_from_fork+0x27/0x40

Same with above.

-- 
Ming
