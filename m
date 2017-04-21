Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <149266673026.27388.11044384829130065082.stgit@noble>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266673026.27388.11044384829130065082.stgit@noble>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 21 Apr 2017 23:43:48 +0800
Message-ID: <CACVXFVP48AQiQiACokPP0ZTRD3rei4Q7wA5Hcuar4R3v=E9Esw@mail.gmail.com>
Subject: Re: [PATCH 10/11] block: remove bio_clone() and all references.
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 1:38 PM, NeilBrown <neilb@suse.com> wrote:
> bio_clone() is no longer used.
> Only bio_clone_bioset() or bio_clone_fast().
> This is for the best, as bio_clone() used fs_bio_set,
> and filesystems are unlikely to want to use bio_clone().
>
> So remove bio_clone() and all references.
> This includes a fix to some incorrect documentation.
>
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
