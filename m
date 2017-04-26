Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Wed, 26 Apr 2017 20:32:31 +0000
Message-ID: <1493238750.2632.13.camel@sandisk.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
	 <20170425203745.19946-6-bart.vanassche@sandisk.com>
	 <20170425213018.GB6361@vader>
In-Reply-To: <20170425213018.GB6361@vader>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-25 at 14:30 -0700, Omar Sandoval wrote:
> Jens, could you ack that dropping the lock is okay?

Hello Omar,

If you have a look at the block layer history then you will see that the
current approach for shutting down block layer queues is an approach that
I had introduced myself. See also commits 3f3299d5c026, 807592a4fafb and
c246e80d8673.

Bart.=
