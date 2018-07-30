Return-Path: <tomi@nomi.cz>
Date: Mon, 30 Jul 2018 17:00:15 +0200
From: Tomas Janousek <tomi@nomi.cz>
To: Ming Lei <ming.lei@redhat.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180730150015.bpgckk73e3jyz4zc@nomi.cz>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
 <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
 <20180730075949.GA1755@xps.pks.im>
 <20180730115002.GA6972@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180730115002.GA6972@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

On Mon, Jul 30, 2018 at 07:50:03PM +0800, Ming Lei wrote:
> Now runtime PM is still enabled for sd/sr, and I believe the following
> patch is needed until we figure out one perfect way for supporting it
> well:
> [...]
> +		pm_runtime_disable(dev);

Awesome, thanks for the quick reaction! :-)

(I don't happen to have a .config for the hardware I'm experincing the problem
on, so don't expect a Tested-By from me, but I don't see why it wouldn't fix
the issue, and it did for Patrick.)

-- 
Tomáš Janoušek, a.k.a. Pivník, a.k.a. Liskni_si, http://work.lisk.in/
