Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC5794
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:02:17 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77f31239797so308100685a.2
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404136; x=1703008936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNF90TjcDNx5VXo+RX2zacD8yj70X1dJBpsDRoeWT0w=;
        b=SM4JOE9vbSumgheunzTbIpLOiuaSjz9KS4nJYQU/Cm8GESflCx8HWONKfPgPU1KSKj
         cYXy97N1HYCFQ4pizYrrSY/sZpkRrU9uY78pG/s5nAGvomG7rTCk/00FqER2UwknxIoj
         3XkeVgaLoQ7NgJSch20LaQB7RW58+8x/04ejgAegAEOXHXkaifl+z3R+BAQiuZd3H7Wx
         +MuZTu01X1+Zwbfh7Q6Q8h/ZrBeQNoShpsHhgo03Tjb9XBdyLjv4SXpAfHUOgfMPWbM9
         4hjsEc9AljrdrsL6Z20yY+6g2CbDAwF4URd9jH0mjJnSsoi3nn5L0ocAr1GIgUeuUF8E
         MbMQ==
X-Gm-Message-State: AOJu0Yw1HDEVdjiBAG7+S/EvVj2uWZ8Ken51ZnRDrP9qRj+Zi0V4EbGq
	b5vxAVoVT8dscei3QifkFcJg
X-Google-Smtp-Source: AGHT+IEqbMyNqp7aJbP8HN56kDy4vGmOA0OlOKeSt3YMS6VC2SyUPCuoSmUUUgLPsVT63mez6BwUFQ==
X-Received: by 2002:a05:6214:141c:b0:67a:a721:9e92 with SMTP id pr28-20020a056214141c00b0067aa7219e92mr7175039qvb.67.1702404136629;
        Tue, 12 Dec 2023 10:02:16 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id rc3-20020a05620a8d8300b0077dc7a029bfsm3902634qkn.100.2023.12.12.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:02:16 -0800 (PST)
Date: Tue, 12 Dec 2023 13:02:15 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Hongyu Jin <hongyu.jin.cn@gmail.com>, agk@redhat.com,
	mpatocka@redhat.com, axboe@kernel.dk, ebiggers@kernel.org,
	zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 1/5] block: Fix bio IO priority setting
Message-ID: <ZXigJ6pf/2MpnciJ@redhat.com>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
 <20231212111150.18155-2-hongyu.jin.cn@gmail.com>
 <ZXhcaQh3UFZmyFmQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhcaQh3UFZmyFmQ@infradead.org>

On Tue, Dec 12 2023 at  8:13P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Dec 12, 2023 at 07:11:46PM +0800, Hongyu Jin wrote:
> > From: Hongyu Jin <hongyu.jin@unisoc.com>
> > 
> > Move bio_set_ioprio() into submit_bio():
> > 1. Only call bio_set_ioprio() once to set the priority of original bio,
> >    the bio that cloned and splited from original bio will auto inherit
> >    the priority of original bio in clone process.
> > 
> > 2. The IO priority can be passed to module that implement
> >    struct gendisk::fops::submit_bio, help resolve some
> >    of the IO priority loss issues.
> 
> Can we reword this a bit.  AFAICS what this primarily does it to ensure
> the priority is set before dispatching to submit_bio based drivers or
> blk-mq instead of just blk-mq, and the rest follows from that.

Yeah, I agree.. something like:

Move bio_set_ioprio() and caller up from blk_mq_submit_bio() to
submit_bio(). This ensures all block drivers call bio_set_ioprio()
during initial bio submission.
 
> > +static void bio_set_ioprio(struct bio *bio)
> > +{
> > +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
> > +	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> > +		bio->bi_ioprio = get_current_ioprio();
> > +	blkcg_set_ioprio(bio);
> > +}
> 
> I don't think we need the check here as anyone resubmitting a bio should
> be using submit_bio_noact.

This patch moves the caller from blk_mq_submit_bio() to submit_bio().

So I'm not sure why you're seizing on the "resubmitting a bio" usecase
as reason for dropping this check (which occurs in submit_bio).

The original justification for the check is detailed in commit
a78418e6a04c93b ("block: Always initialize bio IO priority on submit").

Mike
