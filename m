Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 08:15:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171103001541.GF27370@ming.t460p>
References: <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
 <20171101014611.GA8200@ming.t460p>
 <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
 <20171101020312.GA9527@ming.t460p>
 <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
 <1509638224.2484.14.camel@wdc.com>
 <20171102233835.GA27370@ming.t460p>
 <1509666235.2484.23.camel@wdc.com>
 <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1509666897.2484.25.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 02, 2017 at 11:54:57PM +0000, Bart Van Assche wrote:
> On Fri, 2017-11-03 at 07:48 +0800, Ming Lei wrote:
> > Could you please share your srp-tests script? I may find a IB/SRP system
> > to see if I can reproduce this issue and figure out one solution.
> 
> Please have a look at https://github.com/bvanassche/srp-test.

Could you provide me the exact command line for the reproduction?

I simply run ./run_tests, and looks it doesn't work.

[root@ srp-test]# ./run_tests
df: ‘/home/ming/git/srp-test/mnt2’: No such file or directory
df: ‘/home/ming/git/srp-test/mnt2’: No such file or directory
Unmounting /home/ming/git/srp-test/mnt2 from
umount: /home/ming/git/srp-test/mnt2: mountpoint not found
df: ‘/home/ming/git/srp-test/mnt2’: No such file or directory
Error: unmounting /home/ming/git/srp-test/mnt2 failed


Thanks,
Ming
