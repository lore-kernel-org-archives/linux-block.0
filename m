Return-Path: <prvs=7568bcc2f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] Fix a race condition related to creation of
 /dev/nvme0n<x>
Date: Mon, 13 Aug 2018 18:44:03 +0000
Message-ID: <d258a812b96f3a03512a7c209cf49207411ac593.camel@wdc.com>
References: <20180813172531.7451-1-bart.vanassche@wdc.com>
	 <6f10ca9c-ba9b-50ac-3c8c-fb62d7dd750c@suse.de>
In-Reply-To: <6f10ca9c-ba9b-50ac-3c8c-fb62d7dd750c@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-08-13 at 20:42 +-0200, Hannes Reinecke wrote:
+AD4- I have fixed the very same thing with my patchset titled +ACI-genhd:=
=20
+AD4- register default groups with device+AF8-add+AF8-disk+ACI- which is wa=
iting for=20
+AD4- inclusion.

Thanks Hannes for the feedback. I will drop this patch series and review
your patches instead.

Bart.
