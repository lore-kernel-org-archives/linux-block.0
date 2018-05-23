Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Tue, 22 May 2018 22:16:07 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
Message-ID: <20180523021607.GB12391@kmo-pixel>
References: <20180522235505.20937-1-bart.vanassche@wdc.com>
 <20180523013020.GA12391@kmo-pixel>
 <65261494f966d140a7542fb1533a4dd2f7fd02a1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <65261494f966d140a7542fb1533a4dd2f7fd02a1.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 01:36:02AM +0000, Bart Van Assche wrote:
> On Tue, 2018-05-22 at 21:30 -0400, Kent Overstreet wrote:
> > On Tue, May 22, 2018 at 04:55:05PM -0700, Bart Van Assche wrote:
> > > This patch avoids that KASAN reports the following complaint when
> > > running the srp-test software:
> > 
> > I made a real attempt to get your test suite working.
> 
> Please try a little harder. Everyone I asked to run that test suite
> has been able to run it.
> 
> Bart.
> 
> 
> 

========= TEST   srp

systemd-journald[143]: Received SIGTERM from PID 1 (systemd).
Removed /etc/systemd/system/multipathd.service.
Starting multipath-tools (via systemctl): multipath-tools.service.
multipathd> reconfigure
ok
multipathd> make -C discontiguous-io discontiguous-io
make[1]: Entering directory
'/host/home/kent/ktest/tests/srp-test/discontiguous-io'
make[1]: 'discontiguous-io' is up to date.
make[1]: Leaving directory
'/host/home/kent/ktest/tests/srp-test/discontiguous-io'
Unloaded the ib_srpt kernel module
Unloaded the rdma_rxe kernel module
../run_tests: line 65: cd: /lib/modules/4.17.0-rc4+/kernel/block: No such file
or directory
Zero-initializing /dev/ram0 ... done
Zero-initializing /dev/ram1 ... done
Configured SRP target driver
Running test ../tests/01 ...
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/01 failed
Running test ../tests/02-mq ...
Test file I/O on top of multipath concurrently with logout and login (10 min;
mq)
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/02-mq failed
Running test ../tests/02-sq ...
Test file I/O on top of multipath concurrently with logout and login (10 min;
sq)
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/02-sq failed
Running test ../tests/02-sq-on-mq ...
Test file I/O on top of multipath concurrently with logout and login (10 min;
sq-on-mq)
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/02-sq-on-mq failed
Running test ../tests/03-4M ...
Test direct I/O with large transfer sizes and cmd_sg_entries=255
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/03-4M failed
Running test ../tests/03-8M ...
Test direct I/O with large transfer sizes and cmd_sg_entries=255
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/03-8M failed
Running test ../tests/04-4M ...
Test direct I/O with large transfer sizes and cmd_sg_entries=1
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/04-4M failed
Running test ../tests/04-8M ...
Test direct I/O with large transfer sizes and cmd_sg_entries=1
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/04-8M failed
Running test ../tests/05-4M ...
Test buffered I/O with large transfer sizes and cmd_sg_entries=255
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/05-4M failed
Running test ../tests/05-8M ...
Test buffered I/O with large transfer sizes and cmd_sg_entries=255
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/05-8M failed
Running test ../tests/06 ...
Test block I/O on top of multipath concurrently with logout and login (10 min)
Unloaded the ib_srp kernel module
SRP login failed
Test ../tests/06 failed
0 tests succeeded and 11 tests failed
Unloaded the ib_srpt kernel module
Unloaded the rdma_rxe kernel module

========= PASSED srp in 14s


May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: --------start up--------
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: read /etc/multipath.conf
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: path checkers start up
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: fail to get serial
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: using deprecated
getuid callout
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
/.../srp-test/bin/getuid_callout exited with 255
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: failed to get
callout uid: Input/output error
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdb: fail to get serial
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdb: using deprecated
getuid callout
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
/.../srp-test/bin/getuid_callout exited with 255
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdb: failed to get
callout uid: Input/output error
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdc: using deprecated
getuid callout
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
/.../srp-test/bin/getuid_callout exited with 255
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdc: failed to get
callout uid: Input/output error
May 22 22:13:46 moria-kvm-kvm-kvm-kvm systemd[1]: Started Device-Mapper
Multipath Device Controller.
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: reconfigure (operator)
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: fail to get serial
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: using deprecated
getuid callout
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
/.../srp-test/bin/getuid_callout exited with 255
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: failed to get
callout uid: Input/output error
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdb: fail to get serial
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdb: using deprecated
getuid callout
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
/.../srp-test/bin/getuid_callout exited with 255
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdb: failed to get
callout uid: Input/output error
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdc: using deprecated
getuid callout
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
/.../srp-test/bin/getuid_callout exited with 255
May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sdc: failed to get
callout uid: Input/output error
