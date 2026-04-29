Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6B36E48B
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478335; cv=none; b=dTeJRq2sp0wlqidAvtZ8Kse2tiG4JLCv1edmVoC31d4A6PFeROzIprCpxtJDQjulpdIpN0HDHew1dRXzqWeax8dP6ngtkA67knONKWIHW7Tjdb0QQsh783tFUjMvPzq724BHoDmJC2vr8idnQl9v0IsoAv44Ur1ntyaCJkeR0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478335; c=relaxed/simple;
	bh=bL1oI2T+/QcAyav4PbOZOKZIhEYDZCWxS6CoNwLPGbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjkS81galjfjr0hkb+Yix9riN9hdC1pD3dSVzVNqU0jVQMpAbBXX0kU+PH5oPK2TFoKeMsGQ63asSoo9zMWGKaBumuYEy2ELcTbqUJyLZLyVIK6qEW+QIElItljmo12JCQA2P1mnp52r+DlYjbmtdjmzM8ZDnlE3oowsRayI5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS+8CJX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS+8CJX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777478333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnhFIL+kHv1nOvxllV0EK3JEL4JKFydqeH0J7oPCUog=;
	b=JS+8CJX60d6rJA7TRUPRcBE+BImLIUAMgbNsjJjI9+Vgsy06In5ZnYvl1P/CkiwW8QkX9F
	URvZu4jH8wxHPPweBgqk92Sslf5nYlktmhdw9TMwkarCFIlkunu1jl/yIia8kaQWVCv/mN
	T3KLt6L4rRDONqgfymIbMU0X47KVPaY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-dg8-1hSYMSe39iZfNUPhnQ-1; Wed,
 29 Apr 2026 11:58:49 -0400
X-MC-Unique: dg8-1hSYMSe39iZfNUPhnQ-1
X-Mimecast-MFC-AGG-ID: dg8-1hSYMSe39iZfNUPhnQ_1777478326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE17E19560BB;
	Wed, 29 Apr 2026 15:58:45 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44E4F180034F;
	Wed, 29 Apr 2026 15:58:45 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TFwh352814008
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 11:58:44 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TFwhfH2814007;
	Wed, 29 Apr 2026 11:58:43 -0400
Date: Wed, 29 Apr 2026 11:58:43 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com, hch@infradead.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2 2/3] dm-inlinecrypt: add target for inline block
 device encryption
Message-ID: <afIqszyKboCEmHDa@redhat.com>
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-3-linlin.zhang@oss.qualcomm.com>
 <ae7yzw-5wz9cqZt8@redhat.com>
 <ae_vacHQ75AgZbm_@redhat.com>
 <6390db35-7f8e-4d00-9c1f-43d676007910@oss.qualcomm.com>
 <afDh8XRWW_JgaUP3@redhat.com>
 <7ab5cd97-30b7-42ca-80ce-6d9cd8c45b73@oss.qualcomm.com>
 <afIizQA9kVR_u_2j@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afIizQA9kVR_u_2j@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 29, 2026 at 11:25:04AM -0400, Benjamin Marzinski wrote:
> On Wed, Apr 29, 2026 at 08:34:00PM +0800, Linlin Zhang wrote:
[...]
> > 
> > Thanks for the suggestions.
> > 
> > Adding a bool need_acct parameter to __blk_crypto_submit_bio() would require
> > updating all existing callers, which feels rather intrusive given that the
> > accounting issue only affects the blk‑crypto fallback write slow‑path. I’m a
> > bit concerned that this would broaden the scope of the change more than
> > necessary for the problem at hand.
> 
> I get your concern, and I'd like a second opinion on how much we should
> care about this, but it doesn't look like there are many other callers
> that would be effected here. The only existing caller of
> __blk_crypto_submit_bio() is blk_crypto_submit_bio(), which would just
> call it with "need_acct=true". Looking at the code path below
> __blk_crypto_submit_bio() that would need to change for submitting the
> bios:
> 
> __blk_crypto_submit_bio() is the only caller of
> blk_crypto_fallback_bio_prep()
> 
> blk_crypto_fallback_bio_prep() is the only caller of
> blk_crypto_fallback_encrypt_bio().
> 
> blk_crypto_fallback_encrypt_bio() is the only caller of
> __blk_crypto_fallback_encrypt_bio(), which is the function that would
> need to choose between submit_bio() and submit_bio_noacct().
> 
> Doing this would change the crypto API (by necessity, since we're adding
> a new argument to __blk_crypto_submit_bio() for stacking devices to
> use), and it is adds a extra argument to a number of functions, just to
> handle this corner case. But it is still a relatively contained change.

Having discussed this a bit, I'm fine with leaving this as a TODO for
now. If anyone wants to chime in with an opinion on how acceptable it
would be to add a new bio flag for skipping accounting, that would be
great.

-Ben 

