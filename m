Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7002224250
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831653; cv=none; b=CEvBKcjVKc0bEmwRAtaSty7SGV2GpjP3yXMQA8NAvgP8uSxPun14ulzhkz9uxQGTRldcI5DslfZSJasfH37YWzthSzKY7NxvnPlb74/GTzJvcjLodWp+LaMxD9aB8QTerUboFtx9IoPY0Kue2OosMsF2L0Q+4dLSSPKZkjUVq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831653; c=relaxed/simple;
	bh=+HX0vLDbt3Nq4KmLNN9WWvxRxsEQXWuv5k8tHJJTnn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyUQYbg/i63IKNJl3OhT0mmwNICH+K292+G3qiumE72pNYsV7FtJjTH4PFuaLbNVPzLq8AFfjIgEmP7zWKwAbTyT26zDRpczCXFqtsHjK1AeIcbSA8rJTdTQyag77WFeTOsJjGUgFH6vsj/pEawsTdPwMhzc2MR6y+X5wS7L8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EPjYb1Z5; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EPjYb1Z5"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so182874839f.2
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744831651; x=1745436451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zF3M+7lD6ZzFUsLP8oEcLLe33d4WHxYKwCUyi35c9VE=;
        b=EPjYb1Z5jdC9ie0JH8mRgeXUHM3a/lzOT1zJU9GBUI5XBTvkArxqfjNph791ZCp4Yd
         ZH7avQcgcGhZkhqR0McBE8U+aBPxZ8QUqDRwOUdZbG8s07mUTHqXRFCtRgizCi1XGsFV
         5rlVvUNlVqn+0reXvb+U7MpO4wBl/DzU7qz7SxU4HUZY9J+uw1wnl+jKDePIdfMZYJ7A
         ijYxaOSXBuHd1omvPhKtLuJSTdfpdHZtDxM220F6Ou7m+wZDpG1p8ZE43EoaV+lnydI2
         Y3Sz45lio/vV4wAf6E0DId7ByvajzkfnK6RriAZ+aAXocJVI+VKcZhbkOBoo85Gulziv
         ccIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744831651; x=1745436451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zF3M+7lD6ZzFUsLP8oEcLLe33d4WHxYKwCUyi35c9VE=;
        b=Tb7o8S0vOVd6wW4OybTiF9BtVjl4YErzx1BH2awow9p766W7sUij+hLl5YfPJeGL2o
         8MSniBY9LCrjWsbx46OTP40ImeoSzFeCxyCxyy03dYzElgbPFZhi6yMzvYWl83iFLOof
         q+DC0DLPj6+mxUVonHqgkMApse+j8DB7/RIGmrnizq8Ww8vWJNEoxMZ0ZTAhdZ050X07
         sdX2vlx3HuXXtAX6dGUpy8BmDazU1oS1xnLcbU1GwF97569gKZ4QwUfU/Ef4dC8Flzlx
         zR0Y0ISCVKzIsvGb2BAvpsD1Q2Fe4b/3fPWmPLO3cSkgooRYwJx4SoM1Jv/JdnmGgq5l
         pZNw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8C70WrkQXi5kItRE31e3atIOqNQVxSHA2JQ0/mU9lZrL50f2t2XCFrrxsT4/ukA8ZKD4Qnkvi5IvTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZ2ALQoDf8ftaIJPLBGlqs4ZS7661xCVkds+hEXb+jFHe3nzM
	CCHpBjEIbtpO/YfIpyhMhpRL9whHdneV2DmH0lenSG7/+hamhcH04cUhWGhDFN5SrSdfUCMIYoL
	yzUEOoGixi8CETDxy431KmQHMU6Nhfue/
X-Gm-Gg: ASbGncu7b+5qbBbXy3cn11R2gJA3+aWbK4ZBv/nuRBlo1fglqm451yviwZrbUcDqgme
	Q5jeH1o6+lgGl2ymiJ/5xGBLu9d4qqP1N3NTPZNnQCMVG9A7Xa8G+bt/eWTwTMsXP9U3W11ei1/
	yMOsfUIpqSFYYTNHUH5YQGZozq1Q6kn7MJDPhDww0WnECiNN0cCXjEHBmBbB1az/ga11BDaNLYx
	CGKfdNgJrNwj8Y2oF8BRAaJ98xILsbAUb9ozj/jV8H+HQ4L5akxJv6o635dIKuQEZJtjMXNL/o1
	w4C2V3mKT/rzbD2GxvIohNMfvmRvEjc7sc+fviE9U5s1mw==
X-Google-Smtp-Source: AGHT+IFrYgsOp/J/arpag7Zws2+IT02bCM4z7vwehJ0Re5hglq+tc2N8Urz4P/SXwBRVcxJCtveleQHk0SDj
X-Received: by 2002:a05:6602:3a83:b0:85d:f74b:f8a8 with SMTP id ca18e2360f4ac-861c4f64dbemr365382639f.2.1744831651019;
        Wed, 16 Apr 2025 12:27:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f505e2ecf6sm778170173.67.2025.04.16.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:27:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1F8BE34035E;
	Wed, 16 Apr 2025 13:27:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 1EC37E418F0; Wed, 16 Apr 2025 13:27:30 -0600 (MDT)
Date: Wed, 16 Apr 2025 13:27:30 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ublk: mark ublk_queue as const for
 ublk_commit_and_fetch
Message-ID: <aAAEoifl5tAocAYq@dev-ushankar.dev.purestorage.com>
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
 <20250415-ublk_task_per_io-v4-2-54210b91a46f@purestorage.com>
 <CADUfDZpkDUE8heSFEhA1aCfn3a59D1+=2piWPtRvX3t9FLgjbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpkDUE8heSFEhA1aCfn3a59D1+=2piWPtRvX3t9FLgjbw@mail.gmail.com>

On Wed, Apr 16, 2025 at 11:59:25AM -0700, Caleb Sander Mateos wrote:
> On Tue, Apr 15, 2025 at 6:00 PM Uday Shankar <ushankar@purestorage.com> wrote:
> >
> > We now allow multiple tasks to operate on I/Os belonging to the same
> > queue concurrently. This means that any writes to ublk_queue in the I/O
> > path are potential sources of data races. Try to prevent these by
> > marking ublk_queue pointers as const when handling COMMIT_AND_FETCH.
> > Move the logic for this command into its own function
> > ublk_commit_and_fetch. Also open code ublk_commit_completion in
> > ublk_commit_and_fetch to reduce the number of parameters/avoid a
> > redundant lookup.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 91 +++++++++++++++++++++++-------------------------
> >  1 file changed, 43 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 9a0d2547512fc8119460739230599d48d2c2a306..153f67d92248ad45bddd2437b1306bb23df7d1ae 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1518,30 +1518,6 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
> >         return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
> >  }
> >
> > -static void ublk_commit_completion(struct ublk_device *ub,
> > -               const struct ublksrv_io_cmd *ub_cmd)
> > -{
> > -       u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
> > -       struct ublk_queue *ubq = ublk_get_queue(ub, qid);
> > -       struct ublk_io *io = &ubq->ios[tag];
> > -       struct request *req;
> > -
> > -       /* now this cmd slot is owned by nbd driver */
> > -       io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
> > -       io->res = ub_cmd->result;
> > -
> > -       /* find the io request and complete */
> > -       req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> > -       if (WARN_ON_ONCE(unlikely(!req)))
> > -               return;
> > -
> > -       if (req_op(req) == REQ_OP_ZONE_APPEND)
> > -               req->__sector = ub_cmd->zone_append_lba;
> > -
> > -       if (likely(!blk_should_fake_timeout(req->q)))
> > -               ublk_put_req_ref(ubq, req);
> > -}
> > -
> >  /*
> >   * Called from io task context via cancel fn, meantime quiesce ublk
> >   * blk-mq queue, so we are called exclusively with blk-mq and io task
> > @@ -1918,6 +1894,45 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> >         return io_buffer_unregister_bvec(cmd, index, issue_flags);
> >  }
> >
> > +static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> > +                                struct ublk_io *io, struct io_uring_cmd *cmd,
> > +                                const struct ublksrv_io_cmd *ub_cmd,
> > +                                struct request *req)
> > +{
> > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > +               return -EINVAL;
> > +
> > +       if (ublk_need_map_io(ubq)) {
> > +               /*
> > +                * COMMIT_AND_FETCH_REQ has to provide IO buffer if
> > +                * NEED GET DATA is not enabled or it is Read IO.
> > +                */
> > +               if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
> > +                                       req_op(req) == REQ_OP_READ))
> > +                       return -EINVAL;
> > +       } else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
> > +               /*
> > +                * User copy requires addr to be unset when command is
> > +                * not zone append
> > +                */
> > +               return -EINVAL;
> > +       }
> > +
> > +       ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> > +
> > +       /* now this cmd slot is owned by ublk driver */
> > +       io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
> > +       io->res = ub_cmd->result;
> > +
> > +       if (req_op(req) == REQ_OP_ZONE_APPEND)
> > +               req->__sector = ub_cmd->zone_append_lba;
> > +
> > +       if (likely(!blk_should_fake_timeout(req->q)))
> > +               ublk_put_req_ref(ubq, req);
> > +
> > +       return -EIOCBQUEUED;
> 
> I think it would be clearer to just return 0. __ublk_ch_uring_cmd()
> already takes care of returning -EIOCBQUEUED in the successful case.

Sounds good - your recommendation is also in line with the convention
Ming is using in
https://lore.kernel.org/linux-block/20250416035444.99569-2-ming.lei@redhat.com/

