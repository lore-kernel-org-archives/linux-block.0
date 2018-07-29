Return-Path: <tomi@nomi.cz>
Date: Sun, 29 Jul 2018 11:41:31 +0200
From: Tomas Janousek <tomi@nomi.cz>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
> triggered on your machine.

While Patrick did miss the following patch:

* 765e40b675a9 ("block: disable runtime-pm for blk-mq"; July 2017).

there is at least one other way to trigger it -- enable laptop-mode-tools
or tlp which enable runtime-pm for all devices.

The "disable runtime-pm for blk-mq" only disables it _by_default_, but doesn't
prevent it from being enabled again from user-space, which it is unless one
manually blacklists sd devices from runtime-pm enablement. It's bitten a few
people already: https://github.com/rickysarraf/laptop-mode-tools/issues/123

(I found this thread because I'm also getting the NULL pointer dereference at
00000000000001a8 on resume from suspend.)

-- 
Tomáš Janoušek, a.k.a. Pivník, a.k.a. Liskni_si, http://work.lisk.in/
