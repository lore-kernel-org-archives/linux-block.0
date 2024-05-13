Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495314B949
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601377; cv=none; b=bTVuGQO3EqtNQgXsYC8pXjmFwT/kv2Rp46uXytHqr9SgJwOMJqkM4Q12RC8vE+hreFgJB6Qsu0CDS8FtY7W6OJ2OrJ32xbgg3cqvfOH8l34CRCJdNwnSxvHcSYX1nPtNh/IbvR6jHo/GkmmMj7AdIxmhjAF9SMQu8iv/Gm3ZAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601377; c=relaxed/simple;
	bh=/K5+pcbqvHdmlKOIY6EGxlQYW8ZajxPOAOvXpRv0FbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j31zbUkJW9I906xSXaes9RLVrHeDR6VmY+n3J09SWBYhovLxRNeZKhyU//bWaj1MEk+viQOylhcOG3fWgzpW7s4bPqizhSUNOYNb2os2vf2pRyI2kq+LckYYwYd3OIs0ARlzi/D4KxSYgd8C5/QM77560vRf/FmGjKctgyJ2MIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kew62/v5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kew62/v5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420180b5897so4551745e9.3
        for <linux-block@vger.kernel.org>; Mon, 13 May 2024 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715601373; x=1716206173; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVjlWqAdfLnp41PpnyNhWZSZIhghyWvNnJwtCIztyEM=;
        b=Kew62/v5idseMPnkp4F3MIDryaF9FFyCBe5IoHp8kdaIv6s/GZeDW0KGqOLqak6pH6
         vcER/yR77fsBwjMmEo5E6WugXHxSkbK0gRbnml211CHOyWG0Fx+tVLP07fjYDFVO6Qim
         25V7eS6KfLRDl106PkmJdncPCcR1PTEmidqk3mjaS/ggoe869ELFKrIwjrlcJpOI5hrE
         4SRwHicZx6qaFmaCmAHU5I5gX1jPTii/a7t0+p8tKWfALRLBFsZcCM5SAwE5mDuKxEGa
         c39mY99OHk2VkgwuLTh7rU0JKXBRjYFSYp5SVDWNh/2/uZY3PzaVPMFC7MWGUrJJIeBJ
         Dy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601373; x=1716206173;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVjlWqAdfLnp41PpnyNhWZSZIhghyWvNnJwtCIztyEM=;
        b=xEZMvvsDMgOCexHKvWnWH6Z53n9Vfva6gV8felQ6XslE9hykKdXzueqM2X/UbNi6l8
         atNDyJSVQY2pek9KI3VnZOR2guxr1Ll48vTWmrzfzZ3ce20pdKKmHu2ghqyhfRqxCQSp
         sGtk+5TUJTZ29H02GKxGMON3Juk/t7IEsUdb5bztuYYZDOtKEFz3GLEWv2kSpji1WOc8
         rN8tb+E550q0CkS3jlTtxguVhS6eQhFVvf11abtN/ouYzySCFd4jU1PxROuA9LI7Y1du
         /oWhKgGbQu6CGusqjElzby+c2ULSiIJGvf8QDN2+uffGmikqKXZtS9noaTkX1ek/CgtU
         AmDQ==
X-Gm-Message-State: AOJu0YyhnrstrRYCJWeZaJyh0bjVJjSybF/FAULHhL52/yauWlSKgC1k
	yRCAgJ5ALXP7clKIuf681QuWFZIhgirH0QTBtfDRxlUeJQjoAv5MmU/pFxTfAdE=
X-Google-Smtp-Source: AGHT+IFgswfetSuy8fSnW1jZdJ739NMwh+RprYAmO4yJuBB3g7hQJgzPn7f9sw3vDrnKs/BAr/2Q8g==
X-Received: by 2002:a05:600c:3b26:b0:41f:3ee0:a302 with SMTP id 5b1f17b1804b1-41feac55f70mr66726895e9.30.1715601373573;
        Mon, 13 May 2024 04:56:13 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm154180975e9.29.2024.05.13.04.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 04:56:13 -0700 (PDT)
Date: Mon, 13 May 2024 19:56:05 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Justin Sanders <justin@coraid.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Chun-Yi Lee <joeyli.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Kirill Korotaev <dev@openvz.org>,
	Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240513115605.GE4433@linux-l9pv.suse>
References: <20240410134858.6313-1-jlee@suse.com>
 <11361de9-b145-41c0-8d5e-5312cd710124@web.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11361de9-b145-41c0-8d5e-5312cd710124@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Markus,

Thanks for your review! I will send v2 patch.

Joey Lee

On Tue, Apr 30, 2024 at 06:16:00PM +0200, Markus Elfring wrote:
> > For fixing CVE-2023-6270, f98364e92662 patch moved dev_put() from
> …
> 
> Please add a subject for the mentioned commit hash.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc6#n99
> 
> 
> > This patch adds dev_hold() to those functions and also uses dev_put()
> > when the skb_clone() returns NULL.
> 
> Please improve this change description with a corresponding imperative wording.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc6#n94
> 
> 
> …
> > Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in
> > aoecmd_cfg_pkts")
> 
> I suggest to omit a line break for this tag.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc6#n145
> 
> 
> …
> > +++ b/drivers/block/aoe/aoecmd.c
> …
> > @@ -401,7 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
> >  		__skb_queue_head_init(&queue);
> >  		__skb_queue_tail(&queue, skb);
> >  		aoenet_xmit(&queue);
> > -	}
> > +	} else
> > +		dev_put(f->t->ifp->nd);
> >  	return 1;
> >  }
> >
> …
> > @@ -617,7 +622,8 @@ probe(struct aoetgt *t)
> >  		__skb_queue_head_init(&queue);
> >  		__skb_queue_tail(&queue, skb);
> >  		aoenet_xmit(&queue);
> > -	}
> > +	} else
> > +		dev_put(f->t->ifp->nd);
> >  }
> >
> >  static long
> …
> 
> Should curly brackets be used for both if branches in these function implementations?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.9-rc6#n213
> 
> Regards,
> Markus
