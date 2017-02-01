Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request
 V2
Date: Wed, 1 Feb 2017 19:21:33 +0000
Message-ID: <1485976879.2560.7.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
	 <1485467235.2540.14.camel@sandisk.com>
	 <e1d5f4e6-c63f-545d-710f-d4d10fa8d2e0@fb.com>
	 <1485472465.2540.19.camel@sandisk.com>
	 <e222c541-3239-104d-e0b0-40d19b012b66@fb.com>
	 <1485474426.2540.25.camel@sandisk.com>
	 <b98195e7-6e04-5a59-8b83-ce2e1c5c4e1a@fb.com>
	 <1485477510.2540.27.camel@sandisk.com>
	 <2d971693-b79d-c1b9-fb2a-f5dd04128c68@fb.com>
	 <1485479738.2540.30.camel@sandisk.com>
	 <ecca734c-7a9c-f060-9335-c2de089849c2@fb.com>
	 <37ab009a-bc2d-d2ae-a875-269ab563a430@fb.com>
	 <9cbf0ce5-ed79-0252-fd2d-34bebaafffa3@fb.com>
	 <1485535925.4267.1.camel@sandisk.com>
	 <2c696943-2a44-4f36-f0f8-0bebceb95a4a@fb.com>
	 <1485825148.2669.18.camel@sandisk.com>
	 <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
	 <1485898487.3113.7.camel@sandisk.com> <1485899692.3113.9.camel@sandisk.com>
	 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
	 <1485910862.3113.12.camel@sandisk.com>
	 <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
	 <1485967586.2560.1.camel@sandisk.com>
	 <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
In-Reply-To: <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-02-01 at 09:13 -0800, Jens Axboe wrote:
> So that's changing the elevator - did this happen while heavy IO was
> going to the drive, or was it idle?

I just ran into an I/O hang while running test 02-sq on top of kernel
v4.9.6. I will have a closer look at the dm code to see whether I can
find anything that is wrong in the dm code.

Bart.=
