Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9A324B1E
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394171; cv=none; b=DHXkupIUtL1bPaOJGQUd7IKq0RhkH4D5CLerQ+PDACmCMi7GCxXn1vgldQ58uXGVYLRf1U/ANBQ4+OrQqL//L+M9G6qijgkR5+SBeb3tu6YlWp3aQCYFfYYZTlIO7eSPtfRjP2bCyDAuGOv4FaW1Mn4+xVbSN9uAE0L021YCKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394171; c=relaxed/simple;
	bh=8un1OulDCk2ibQ4l6hGhMF4v4zYWxLDYerLvstBbjlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZaTLijUc4wYpprbMiJa9DRH7EHvM6ExoixHZmm2/ubxDSxFtLjbYK2u0JJLI5Aizjz40JdrykgAOSAuN4JK0JtWzsowuvlALgiXQM2wqEysKHl+otYAnP2xOvhNPQ1nOZZLUmrMVY1EaYun1SUqbQQzsLTMeAuq2XpM51FNUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJfkXf4Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJfkXf4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777394169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iS1wMNcjHCnwwgf8LmNR6VBXfgy2XtozkmQUrqdxWB8=;
	b=EJfkXf4ZJ6n7S/pk3MQKDOf60qy55fGV/9UDnbjO9ykaNnpGqhvIp3wGWhQBnb8+FzboEN
	gXSCp8xmscY64kdOlx+c62/KkREd1ww2gioMNB4wko6DPc8WlWW9OuT6OJ0+TKrXS5K/d9
	nVcVGD3Y3x5t+UmHHEh02mzDyYFrt04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-BbEEHzahMVWaMvXxFUwhiw-1; Tue,
 28 Apr 2026 12:36:06 -0400
X-MC-Unique: BbEEHzahMVWaMvXxFUwhiw-1
X-Mimecast-MFC-AGG-ID: BbEEHzahMVWaMvXxFUwhiw_1777394164
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E3791800245;
	Tue, 28 Apr 2026 16:36:04 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D146300756E;
	Tue, 28 Apr 2026 16:36:03 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63SGa2RO2773691
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 12:36:02 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63SGa19r2773690;
	Tue, 28 Apr 2026 12:36:01 -0400
Date: Tue, 28 Apr 2026 12:36:01 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com, hch@infradead.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2 2/3] dm-inlinecrypt: add target for inline block
 device encryption
Message-ID: <afDh8XRWW_JgaUP3@redhat.com>
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-3-linlin.zhang@oss.qualcomm.com>
 <ae7yzw-5wz9cqZt8@redhat.com>
 <ae_vacHQ75AgZbm_@redhat.com>
 <6390db35-7f8e-4d00-9c1f-43d676007910@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6390db35-7f8e-4d00-9c1f-43d676007910@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Apr 28, 2026 at 05:20:07PM +0800, Linlin Zhang wrote:
> 
> 
> On 4/28/2026 7:21 AM, Benjamin Marzinski wrote:
> > On Mon, Apr 27, 2026 at 01:23:27AM -0400, Benjamin Marzinski wrote:
> >> On Fri, Apr 10, 2026 at 06:40:30AM -0700, Linlin Zhang wrote:
> >>> From: Eric Biggers <ebiggers@google.com>
> >>> +	/*
> >>> +	 * Since we've added an encryption context to the bio and
> >>> +	 * blk-crypto-fallback may be needed to process it, it's necessary to
> >>> +	 * use the fallback-aware bio submission code rather than
> >>> +	 * unconditionally returning DM_MAPIO_REMAPPED.
> >>> +	 *
> >>> +	 * To get the correct accounting for a dm target in the case where
> >>> +	 * __blk_crypto_submit_bio() doesn't take ownership of the bio (returns
> >>> +	 * true), call __blk_crypto_submit_bio() directly and return
> >>> +	 * DM_MAPIO_REMAPPED in that case, rather than relying on
> >>> +	 * blk_crypto_submit_bio() which calls submit_bio() in that case.
> >>> +	 */
> >>> +	if (__blk_crypto_submit_bio(bio))
> >>
> >> This will still double account for fallback writes (which call
> >> submit_bio() on the encrypted bios, and return DM_MAPIO_SUBMITTED here). 
> > 
> > Just to clarify, I'm talking about the vmstats accounting. The IO
> > originally gets accounted by submit_bio() when the bio is submitted to
> > the dm device. For actual inline encryption and fallback reads, dm will
> > submit the bio to the underlying device using submit_bio_noacct() to
> > avoid double-counting the IO.
> > 
> > For fallback writes, __blk_crypto_submit_bio() will submit the encrypted
> > bios to the underlying device with submit_bio(). This adds the IO
> > sectors again, even though it's the same IO, only encrypted now.
> 
> 
> Right, thanks for calling this out.
> 
> For fallback writes, the IO is still double-counted. Given that this only
> affects IO accounting in the blk-crypto fallback write slow-path and not
> correctness, I think this is an acceptable tradeoff, and we can leave a
> TODO to revisit the accounting once a better solution exists.
> 
> Add the bellow to the annotate.
> 
>   /*
>    * TODO: blk-crypto fallback write slow-path currently double-accounts
>    * IO in vmstat, as encrypted bios are submitted via submit_bio().
>    * This does not affect data correctness. Consider fixing this if
>    * a cleaner accounting model for derived bios is introduced.
>    */
> 
> Do you agree?

You could add an extra argument, for instance "bool need_acct", to
__blk_crypto_submit_bio(), and plumb it through to
__blk_crypto_fallback_encrypt_bio(), where it could be used to choose
between calling submit_bio() and and submit_bio_noacct().

We could even add a flag to cloned bios for stacked devices, that could
be checked in submit_bio(), so we didn't need to have
submit_bio_noacct(). But this is a pretty niche case with other
solutions, so I'm not sure if it warrants adding more checks to
submit_bio().

I do agree that people probably aren't using dm-inlinecrypt for devices
where they don't actually have inline encryption capabilities, so it's
not a major issue. What to you think, Mikulas?

-Ben
 
> > 
> > -Ben
> > 
> >>
> >> -Ben
> >>
> >>> +		return DM_MAPIO_REMAPPED;
> >>> +	return DM_MAPIO_SUBMITTED;
> >>> +}
> >>
> > 

