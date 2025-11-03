Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F4296BDA
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154296; cv=none; b=bS3y6+urSJd6CPsvs6Zs5VrtF/abVf54JA8qXDSyrEtCI6pFeAJnmemUOwZD6THhsUEtz6jmo0P2Fz/XATd7BEUr6F2FbhjnKKdJPIXI4LDwtNhPhpS4v4nUHvFVbBZ+r0PGxiDVha0oc+rQ5YU/pZ2aYq5P7U1OLIKKpBrcKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154296; c=relaxed/simple;
	bh=mNiBHRHLdMqnvaJIEavpx7C7tTm8CYCoyLazYi6SDLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHVHiC9ItVsZN1b1i2Nc7iGf8AvhY2Vkeil4covpaSsDwfD+MPwx/pqkm+nI4CWPq3bcF4D9gsvqP44QVM5Qre/OlcCLxGqfOxeXi9Uvky2Thmuca9Tg1cRA/7vwIF4vMTWD7B+5+CjdyTag3NDCvnzxIlc5EiqAKEqzzazS6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NBvkeDKl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NBvkeDKl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso25682255e9.3
        for <linux-block@vger.kernel.org>; Sun, 02 Nov 2025 23:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762154293; x=1762759093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=;
        b=NBvkeDKlfAkIDsV3UME85lnO9awL8QzNTwhFYaIiXF9Af/y9CYyrD70ovpNljZmod3
         rFP7K3fGfVVqsaBHO6UKTsL+kif5I7mVOUCMLTCcb5wcGyYI1jGpsZKnXqYcNavXmv19
         Yr1fgqjxa6wHgu9aIKZ+qOY7FxuDKLNXa3XqLlBfAxvq5wnFec/HEXubeEttJlb6fFu3
         1/DXeHl2ZQ//HVGCciwqXamvP0mSsXWGOONj6Dxx560+qhaFySNYYjtMztf1MS0mjZll
         WHJdl+kqkVsyORk2/8wZZ8tt8O8rYf+W52e6SHEsgAvy4Z6D1ZssqXRP9yzOrjST19yM
         vmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154293; x=1762759093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=;
        b=rq+K4izsJbscp45KMoXiZsYjkpAJgFeS5hEHfbKb5U1VXdPwv+b8GDwWhADPp7Oo2V
         /1hA+H7DS2ke/N9zjOotF9hwE4h+xZqNpu0igVpMT9t6ste2Bv2jyrX7GIngCxSaMMvZ
         qC+jp+OxLO6Mt5XSCU9BduDME5JsHQSRWRuQGfzyekU07OUvA6KLkP8Y8QH/7cA1/FrK
         iCi+CemgcD9AIUz3G6Ewfswhrib2jjpj6vfloBymF0+y/g0j7bzA6X45BUQMdDQz+9EK
         kAIBECFEmExFnlSa2kprw82wwr2fGFsa8aktnJzV/jODx3EcVUzzZ9ulycp6uB8wvL2s
         /ZeA==
X-Forwarded-Encrypted: i=1; AJvYcCWWygJUE+Cs9eqEdIhL/4h2SEE6znU0mzNd6Cyj4+FoU1ko/Ru5kO3V6fenkmWn8WYiLWOkwWo2gZDiFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwipEbPpBdPLIdhz3WllSgLAPkFOHMgRKmhZCcNSoUZ9yZdvdEG
	mepCOzUWXpPMU0UE+6FRmNrftArMfE3VC24Pb4VBvKc5P4xvJsC2dU98jJ/5XE8HeqO+QArsfEP
	dZzXp4yfohrdthCrz3DNZVl2Lro7m2hCM3sY/HCPH8w==
X-Gm-Gg: ASbGncsR77DbQmV0ZHvhlZ9fh44uXnZK8C6jyNFG6L2t4lEnIJdCkyyHLMQNfNwB9LF
	TGsAtBuQfH72B6kHqGMKpvHzZdWKV0VIto9+sbEmalOMAMqO1fyY146awMbpa7y+1gGbDrqBoCy
	edz6FosNxyYKRDKu+dc/gtPSKv+SH4/X6EoTAvuVG3rQXiErmhl1CN+whQJL6UiJ3/9c0pv+JuU
	9t8Ht3nj1Z2ff8wwpdPaTfSo2ynMawHNahyq1Wj+xSG5Yx43fzFCfvSMfzivxVITB0Sd5eDknCz
	YEOlINm1hv3RfWNSkdqV2VQc0ZafnWiS8DoV1+VH76y0zQGZgGEnCxWhsxX0yBjQXSfa
X-Google-Smtp-Source: AGHT+IHqUQu8mdmKFV60YUxpDIMFoEiDUTPxoVdwOa3d9A2KABNI1QO1FJGgMlmc/MHoUnrp0Cz2XrvfjpDIzK4Hz9g=
X-Received: by 2002:a05:600c:620a:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-4773bf42644mr79682075e9.7.1762154292857; Sun, 02 Nov 2025
 23:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-2-dlemoal@kernel.org>
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org> <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
In-Reply-To: <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 3 Nov 2025 08:18:00 +0100
X-Gm-Features: AWmQ_bmxLu0zc6F1WlZXfm4Psv5Sxs14UirqMZbxcqRpQmruSk8F7QkSWlVIM64
Message-ID: <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>, 
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 06:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 11/1/25 02:48, Bart Van Assche wrote:
> > Hi Damien,
> >
> > disk_update_zone_resources() only has a single caller and just below the
> > only call of this function the following code is present:
> >
> >       if (ret) {
> >               unsigned int memflags = blk_mq_freeze_queue(q);
> >
> >               disk_free_zone_resources(disk);
> >               blk_mq_unfreeze_queue(q, memflags);
> >       }
> >
> > Shouldn't this code be moved into disk_update_zone_resources() such that
> > error handling happens without unfreezing and refreezing the request
> > queue?
>
> Check the code again. disk_free_zone_resources() if the report zones callbacks
> return an error, and in that case disk_update_zone_resources() is not called.
> So having this call as it is cover all cases.

I understand Bart's idea was more like below:

> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(str
uct gendisk *disk,
>       }
>
>   commit:
> -     return queue_limits_commit_update_frozen(q, &lim);
> +     ret = queue_limits_commit_update(q, &lim);
> +
> +unfreeze:

+       if (ret)
+               disk_free_zone_resources(disk);

> +     blk_mq_unfreeze_queue(q, memflags);
> +
> +     return ret;
>   }
>
>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,

And then in blk_revalidate_disk_zones() do this:

        if (ret > 0) {
                ret = disk_update_zone_resources(disk, &args);
        } else if (ret) {
                unsigned int memflags;

                pr_warn("%s: failed to revalidate zones\n", disk->disk_name);

               memflags = blk_mq_freeze_queue(q);
               disk_free_zone_resources(disk);
                blk_mq_unfreeze_queue(q, memflags);
        }

The question remains if this looks better?

> --
> Damien Le Moal
> Western Digital Research
>
