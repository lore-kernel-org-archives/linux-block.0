Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B13ED135
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904833; cv=none; b=WAaBN/sm1M518qg3KiwqL6EGdeDkZYTHxZ5panGsj+tLpozEasSBLMKSKsGk2pdqm3QT1wfS7fBWi9whCo5rXdU4M24LayUv4VnFnUbfL+HlWXFbzuVeBp/8PGxIaul2sNifaiCq6dF/PeeJvxxRHlbrH5CLOYSvvF2WCH8zIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904833; c=relaxed/simple;
	bh=uCEWYU2Al1i1RDivX5HCNm7JcyuJQ2TuUqwzkCAfF4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6fYqw6cSIKQzvKx4vKh1QIUt4p+HSwFSVF15wEu0unlzbiuwpC4dCXdeOVIen3GTC2NqGJh84lpVmZOokTbuSG5H9kWhOSt33Y1pkjBbNRC7HaSviyOwUxtS5pIQLYRDoje09HKg63KUnvYoLZlac+ozCaTBsmbbgObae7cBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ARmobf+L; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ARmobf+L"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so32903615e9.3
        for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 02:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768904830; x=1769509630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCEWYU2Al1i1RDivX5HCNm7JcyuJQ2TuUqwzkCAfF4o=;
        b=ARmobf+LH+SLF2eykKjTXs6ojlrTL9BrofW2lIDxN8rtj2KZ71Oh8QoMMd50JK2oWa
         K+X2zOLPUXBHZSDlXCKLWyCLsev8mZ08JIgT6y4fOdIFPYb69GGvKUpol+qqKoE1X+xm
         HZq9NukrH2rC79DTdxor7qZP2Bt05blEZB2vkN2ZHOkIixwyQ1u6Zb+pHTfPUdTMy3nC
         lFGAb+N7Q5Lmun0mJeJX98lLMrl9yhC2p5wWP3bt51QOXNRRHRtJMD2nxUCIAsbktue0
         g0tB6LmGmr1nGnpu7LKUG2ZGparCv90sNh1CNJTt954MxMr3jC6Wxn3YKJWRXT922y45
         aYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904830; x=1769509630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCEWYU2Al1i1RDivX5HCNm7JcyuJQ2TuUqwzkCAfF4o=;
        b=Ed/pTUU/CMOFs76InTS2bpsVlvzu0ldmq4nxqxMZuP+5ao7X9UQwrrSbzU8ZYY0daY
         uFitCQD4xq8qi0v8VBxSr9NF80VHbhIrrhuZ+Qqm4G3RzgFkqXl/ldKBP9QwF9+BDYHD
         gX2/KxR4Mx/OR/VmT3l7yb9/Nj86ynft9SuO24jZbybp506HvC9yCa7vWwCOl+UdWEl2
         PTsTcuDhr8XlMtoNLSnUhyAr/SFJgmjcJgss+LtD+xT91q4DAL+1DPjXTLJwJELBrzOO
         Nw1WAed352C5Z0syheVL+twRqWhOZpt5kVW0bvuz8HZ1sU6XqXu1jQG8Og+arYp53kZF
         DPbA==
X-Forwarded-Encrypted: i=1; AJvYcCXdUMYhn2nV6q6gaoFfKCRp3xuan87EaCvTpDpf/nJ9eGSEWcS5RwVH84faSThdtuoAXAyK8zyibkqAfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ivxSfEAuXywgNXD3Ghejl0N0Yt+zxPr/Z0qPoCRQwfwzrsK9
	9nZAeRwLOZ2yYqew2MNU5jhcmGa0rmfQMWvNJU10892Cik+0uAfBw97fE2QDiTjuUTc=
X-Gm-Gg: AY/fxX4VemUJpz/QJro4MCWFL7wYMLlW8TtYVbxIS/y7Gqtvu5MGm17aeR6R9IHUS1U
	L2geezoC8ZAVjWS8V1DkmrrkgZGUSt2pWxdvjUR+lfl5UCq9BZlpTxfSsAFpUuQAEA/Hvl7Xrl4
	5rgupJf+DXRNTX/CEJbcUKLTi2ZmMFtdiHguJXmwzOfUNxOO+dFt3+ynQIgnCRcw531ZYt1fJMb
	/+Uf0HSSUMYfqXIbFKLdWlAHX4sDGXRqBn0pq11D9rzcF9PaYSWvL5l3j2814gAZg6rXQfRFI1b
	WJ249RYK32bRqODA/9wX3MV7g+3rniMp2D/VITZqEC1/8f3w6aGQuoXjT77EUoIMM9ITotN8+Bf
	WkzKm9HVfMLhrfrndsJKdWCrfMWzcYxWFZpNnGa3YOXI+ZmCav0296dKA7oJ2KPYYukbBrmF1B+
	QLVLukAwBgUg5ukJHBXpRs2GvIDZDJqCA=
X-Received: by 2002:a05:600c:3483:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4801e334248mr182913705e9.24.1768904829791;
        Tue, 20 Jan 2026 02:27:09 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b267661sm300938025e9.13.2026.01.20.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:27:09 -0800 (PST)
Date: Tue, 20 Jan 2026 11:27:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org, 
	nilay@linux.ibm.com, ming.lei@redhat.com, zhengqixing@huawei.com, hch@infradead.org
Subject: Re: [PATCH 1/6] blk-cgroup: protect q->blkg_list iteration in
 blkg_destroy_all() with blkcg_mutex
Message-ID: <sq7fx334im64pvgiieemit4sb67z4p3ftoc4544rsea2ojy4u4@mtwvaerxqikn>
References: <20260115163818.162968-1-yukuai@fnnas.com>
 <20260115163818.162968-2-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="skz75jirqnv3i5o3"
Content-Disposition: inline
In-Reply-To: <20260115163818.162968-2-yukuai@fnnas.com>


--skz75jirqnv3i5o3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] blk-cgroup: protect q->blkg_list iteration in
 blkg_destroy_all() with blkcg_mutex
MIME-Version: 1.0

Hi Kuai.

On Fri, Jan 16, 2026 at 12:38:13AM +0800, Yu Kuai <yukuai@fnnas.com> wrote:
> blkg_destroy_all() iterates q->blkg_list without holding blkcg_mutex,
> which can race with blkg_free_workfn() that removes blkgs from the list
> while holding blkcg_mutex.
>=20
> Add blkcg_mutex protection around the q->blkg_list iteration to prevent
> potential list corruption or use-after-free issues.

I'm little bit confused why q->queue_lock is not sufficient for this
problem. (If pd_free_fn() was moved after list_del_init() in
blkg_free_workfn().)

I'd find useful some overview of the involved locks (queue_lock and
blkcg_mutex) and what data structures are synchronized with each of
them. It'd help to disambiguat which locks are needed where.

Thanks,
Michal

--skz75jirqnv3i5o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaW9YbBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AivvQD/QdEFpSn/BsD5QnvcmK0g
WEcYYbMLWP5G6uzWjlI9QQAA/R1oNcLVKIXy/ctc2g6fiWT+qy3k1nTH0R4JvQNB
OgoD
=FZq0
-----END PGP SIGNATURE-----

--skz75jirqnv3i5o3--
