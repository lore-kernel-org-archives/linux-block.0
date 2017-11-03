Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 10:12:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"Hellwig, Christoph" <hch@infradead.org>,
	roman.penyaev@profitbricks.com, linux-block@vger.kernel.org,
	osandov@fb.com, "Reinecke, Hannes" <hare@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171103021234.GH27370@ming.t460p>
References: <20171101020312.GA9527@ming.t460p>
 <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
 <1509638224.2484.14.camel@wdc.com>
 <20171102233835.GA27370@ming.t460p>
 <1509666235.2484.23.camel@wdc.com>
 <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com>
 <20171103001541.GF27370@ming.t460p>
 <1509670091.2636.0.camel@wdc.com>
 <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hi Laurence,

On Thu, Nov 02, 2017 at 09:16:04PM -0400, Laurence Oberman wrote:
> Hi Ming
> I have used Bart's tests on my test bed they should run fine.
> Are you using my SRP setup.

Yeah, I am using your SRP setup.

Once the three directories are created, I saw the new failure,
and both ib/srp and dm-mpath has been working well now.

Laurence and Bart, do you have receipt for making the test
working first?

[root@ibclient srp-test]# ./run_tests
modprobe: FATAL: Module target_core_mod is in use.
[root@ibclient srp-test]# lsmod | grep target
iscsi_target_mod      294912  1 ib_isert
target_core_mod       352256  2 iscsi_target_mod,ib_isert
[root@ibclient srp-test]# lsblk | head -n 10
NAME                                   MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sdy                                     65:128  0   3.9G  0 disk
└─36001405b2b5c6c24c084b6fa4d55da2f    253:16   0   3.9G  0 mpath
sdam                                    66:96   0   3.9G  0 disk
└─360014055f563ebf2abc4609a00a16794    253:11   0   3.9G  0 mpath
sdbb                                    67:80   0   3.9G  0 disk
└─36001405f58163b828714988bd2e88358    253:17   0   3.9G  0 mpath
sdf                                      8:80   0   3.9G  0 disk
└─36001405fb1402260c1346688f23d07e0    253:7    0   3.9G  0 mpath
sdau                                    66:224  0   3.9G  0 disk

Thanks,
Ming
> 
> Thanks
> Laurence
> 
> 
> On Nov 2, 2017 8:48 PM, "Bart Van Assche" <Bart.VanAssche@wdc.com> wrote:
> 
> > On Fri, 2017-11-03 at 08:15 +0800, Ming Lei wrote:
> > > On Thu, Nov 02, 2017 at 11:54:57PM +0000, Bart Van Assche wrote:
> > > > On Fri, 2017-11-03 at 07:48 +0800, Ming Lei wrote:
> > > > > Could you please share your srp-tests script? I may find a IB/SRP
> > system
> > > > > to see if I can reproduce this issue and figure out one solution.
> > > >
> > > > Please have a look at https://github.com/bvanassche/srp-test.
> > >
> > > Could you provide me the exact command line for the reproduction?
> > >
> > > I simply run ./run_tests, and looks it doesn't work.
> > >
> > > [root@ srp-test]# ./run_tests
> > > df: ‘/home/ming/git/srp-test/mnt2’: No such file or directory
> > > df: ‘/home/ming/git/srp-test/mnt2’: No such file or directory
> > > Unmounting /home/ming/git/srp-test/mnt2 from
> > > umount: /home/ming/git/srp-test/mnt2: mountpoint not found
> > > df: ‘/home/ming/git/srp-test/mnt2’: No such file or directory
> > > Error: unmounting /home/ming/git/srp-test/mnt2 failed
> >
> > This means that I have to add the following to the README document:
> >
> > Run "mkdir mnt1 mnt2 mnt3" before starting the tests.
> >
> > Bart.
