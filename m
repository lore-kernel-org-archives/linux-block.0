Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 11:50:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "loberman@redhat.com" <loberman@redhat.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171103035050.GI27370@ming.t460p>
References: <1509638224.2484.14.camel@wdc.com>
 <20171102233835.GA27370@ming.t460p>
 <1509666235.2484.23.camel@wdc.com>
 <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com>
 <20171103001541.GF27370@ming.t460p>
 <1509670091.2636.0.camel@wdc.com>
 <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
 <20171103021234.GH27370@ming.t460p>
 <1509676969.10883.0.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509676969.10883.0.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 03, 2017 at 02:42:50AM +0000, Bart Van Assche wrote:
> On Fri, 2017-11-03 at 10:12 +0800, Ming Lei wrote:
> > [root@ibclient srp-test]# ./run_tests
> > modprobe: FATAL: Module target_core_mod is in use.
> 
> LIO must be unloaded before srp-test software is started.

Yeah, I can make this test kick off after running
'modprobe -fr ib_isert' first, but looks all tests failed without
any hang, could you check if that is the expected result?

	https://pastebin.com/VXe66Jpg

Also could you provide some output from debugfs when this hang happens?
such as:

	dispatch/busy/.. under hctxN

-- 
Ming
