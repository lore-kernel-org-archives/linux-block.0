Return-Path: <prvs=730b8c8b8=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"raghuhack78@gmail.com" <raghuhack78@gmail.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Date: Wed, 18 Jul 2018 18:06:42 +0000
Message-ID: <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
References: <20180718155855.4949-1-raghuhack78@gmail.com>
In-Reply-To: <20180718155855.4949-1-raghuhack78@gmail.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 21:28 +-0530, RAGHU Halharvi wrote:
+AD4- +ACo- Fix all pointer declaration which causes
+AD4-    +ACI-ERROR: +ACI-foo+ACo- bar+ACI- should be +ACI-foo +ACo-bar+ACI=
AIg-

Hello Raghu,

If you would not be aware of this, checkpatch is a tool that is intended to
verify patches before submission and not to verify code that is already
upstream. A detailed explanation of why patches like this one should not be
submitted is available in +ACI-A quick guide to why stand-alone checkpatch
patches suck+ACI-
(https://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-September/012=
296.html).

Thanks,

Bart.=
