Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D37E72630
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033736; cv=pass; b=MIN4BEG7fAKkScoXYQvcUil5M+zI0oplEdevakjZu6McMFkjUelqmPOx8bzHW9sSxwNckIL/HDJlEuQi8FOk3PzyCcrJ6O93Wxbgr04KvO2wnMx86BFqiQjnPXqhOjydve/Z2NHCFz/1sczq8KAJaKeo2PgabygGsFTIc0zh8oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033736; c=relaxed/simple;
	bh=lVtttX0DzcbNoip3+pABR2VEbh4QnI/gjbjrOBn9+DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc7Cp31tFSMB3DO5vhRwMfQ4kOFz/ETNiiR2tXOq4oxpnyFkQKCGOjDidNEiBVQak81k3PCrly4Go9ElfUiZgFAwCZAIzKkllHZ9HfxZpBBOmUQUF6ZxcRJAdScNMt9nsuBSrhhOznIq9BaBH1Ia0IKWOYInGUs2OHtF61fyrfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtUfVVZx; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtUfVVZx"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-495b27007d0so1452124b6e.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 09:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786033734; cv=none;
        d=google.com; s=arc-20260327;
        b=M7RUXRdFXS29O2eM+xm1Fjp2XPrdbsRV66tQMA8Quc0H6Zd9XG2T8C9dugqHkBtgqK
         QiNscplFu2cOJt35Rhx9kY+FoZgMzEfy1MAD/dAs2EL6bfp+o7WBhc06QWWRGwsaoGLV
         ft60EU6s7W/NX00UkDVrjRxsTdCOpLNGApJ+Dfw/XMT6c+7HI8cTClCQiHyGOdMNiLH+
         ife28EJEkY0RKTTgMg89NqWmedyjd6heZht5L3xXtqnuySKSYZloNAwZKNwoCzmr9kp2
         UIAWVkn2qGhTA+NePmhEUVZe2TUN8tVszJBFx6ct/P5V3/1UaMJcPAUvmuvpVti5ohVH
         nDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=orDEibAEujnNc9Q2xRVZqj100QoyLPb7T1VtzpVgq8s=;
        fh=YNUjK3w9Dcux9OcU+JsZ2vIJ7ZbwhSI/st2lbsqwo9E=;
        b=pMcMYjrbUYqibtUogqjPalylpzrfrXUXgKzvIDeU0SAuFbcaUKDwL6EQdFXp/dTETo
         vpnn9enFcdo8otcunbXFodNt1mH9TQSWim3oHUnSvcF+G+KbSIX7MEz1yd/GZUhPdBbD
         lzaFuQUV5u7f1VCEIzWrHHeHE89dci3eIxwQ+wlxh5NJcGYjDb5c/MLjNHVSuj44nnBU
         gns5PFgrmPoBjBOGjaZxzDoWgsTogz8HuZn19RjrheZQq88Pi6pAISJz3vqNidbvD6Th
         hsX6pqpJxZ1/7a/ZEYVaZSAr0390b+14My8dnroPeZzIopBGkeYRCAHZf9dFuDFxhhcA
         ZyNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786033734; x=1786638534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=orDEibAEujnNc9Q2xRVZqj100QoyLPb7T1VtzpVgq8s=;
        b=LtUfVVZx31jrUGbT/A1glmwte/QI8wrjG30x9G+m2NUW7gpNgKTznwPhZ/wdIjhrXv
         0f+BwcPp3W9Nc/0GY4JvYF6EwX7E70nmTzSCIFkZZE33nmx7y7BGOHdohD9hqt5glsXl
         Cy3CLC8/kixwVfj66uRH0aOMs/xnqUifHri9AWKR2djbTKioRt2DepDbnBMvn8/pIrSR
         y46tBXINTO91gerqAOfDkLSB64ehdvKMPzfsE7Mgv31Un68TQrAgkTEJU7aw8AyNFdan
         H9uCrwx2pcTPKGRlMxE946yHdu9hJWPF0XyV8nI6rno7E2dPKOdwQ7XWdY0eskKIn6g4
         XJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033734; x=1786638534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=orDEibAEujnNc9Q2xRVZqj100QoyLPb7T1VtzpVgq8s=;
        b=W3/a/sMfgkSXZTQH5YihvbQDRWPALLlWLV0SlAjct85RG+XN+uPNvlWxgR1ROxOXm7
         Jsh/IjFTyn6Y7fnDKTHColJyXjI9GEnJzR1bcwRd2vIUmg8affztY32YEY5mQa4PrGtm
         F5bzntrhzP4jnMyt5RU5vkBaB5g5eWwzBLpTkd0mMiJPmfQlnkjgSQIkc8cRb81XjQW3
         njfLXsZLSQ7j5evPz+mTxqvpu0AM3cStB7u0dF/RkFi/gYZOVnaoI9+c2jrR2EZpCe3i
         CDx77UQ2JBaVdAezQB3kG+Iv+453f+l/M0Mxj2filI2R0frZkzT8xcufmOgWLCHNen/G
         P1Eg==
X-Forwarded-Encrypted: i=1; AHgh+RrCxrVUilz3eHdYp3oZ4yjPXI2sjAbbN93qwzkXph6elhPLd7Cuq2Q0F9wgeAnKpJk2eGH1eQc460Vvow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8AZtrgxemgfVUnrVVE+A6KqHCzyBtoB4chVzyKfrW0XipMxo
	qiOYt7iTlMCLCVJWI99FdH3A1eSK6Lfdf8wDDg0nTMuIpykNXuPoUzTF2F2qmneYBVc2OgLRF+4
	zh2LA/qcNEwlQsy3boG/izWsU1jyOXXpehw1i
X-Gm-Gg: AR+sD11MRo7vRjnp0PacsAwf78NsKsDJ3qVnjRJFhok8E5tsVpxmoIYzDvAAi5XL3gq
	F5Az3unpabEH99T79NrcYmblw1DUjYbqdu4eHLoFCH7HpMDcs4CCB5MhztKORnWPxxwnpd5NTqS
	UDTnHk1y5L4tCTz7xbbhB7Gx8HRF22OoY6ghh1pRN0uEMt0dkY3VjUJK/p8XLTOz9aYA9g9M0HW
	dtVRY0hwE5czb1XOjRNs0829fF5ssULqyKkewEkwAs+uzlIFTDpXtA/FVj7LHzP73uG1kxhfzaU
	xq66V7/tYP192jToOdKVLB994QYiAzGaPLfdDeTxfjhkkmUIgrVRs1FlpHIvjtJ7Xsnl2KNJdQS
	9oqW8JT5qPNJzQXizZfjEA/xzXvhr82OB8cA2IJU6ccxC
X-Received: by 2002:a05:6820:1c88:b0:6a3:f41c:de81 with SMTP id
 006d021491bc7-6b02169ba70mr1487214eaf.35.1786033733969; Thu, 06 Aug 2026
 09:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804125736.2011774-1-sangyao@kylinos.cn>
In-Reply-To: <20260804125736.2011774-1-sangyao@kylinos.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 6 Aug 2026 11:28:40 -0500
X-Gm-Features: AUfX_mzXw6LeFGPyMPl-amHszJY-KjPag8wb51yRMpcG0iZjWc5OHA89_3DXZUI
Message-ID: <CACVXFVO000kDV6CnuBKRs=NALPXK+QMLM0y_d2mZz=KwD-yKiQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: avoid teardown retry loop on xarray allocation failure
To: Yao Sang <sangyao@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:57=E2=80=AFAM Yao Sang <sangyao@kylinos.cn> wrote:
>
> __ublk_shmem_remove_ranges() removes matching maple tree ranges in
> batches, but first stores each range into a temporary xarray so that the
> pages can be unpinned after dropping the maple tree lock.
>
> That temporary xarray is filled under the maple tree lock with
> xa_store(..., GFP_ATOMIC). If the store fails before mas_erase(), the
> current range is left in the tree and the helper returns false. The
> outer ublk_shmem_remove_ranges() loop then immediately retries the same
> range. While the atomic allocation keeps failing, the teardown path has
> no forward progress.
>
> The issue can be reproduced with radix_tree_node failslab injection after
> a SHMEM_ZC buffer has already been registered:
>
>   # Kernel config:
>   #   CONFIG_BLK_DEV_UBLK=3Dy
>   #   CONFIG_DEBUG_FS=3Dy
>   #   CONFIG_FAULT_INJECTION=3Dy
>   #   CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
>   #   CONFIG_FAILSLAB=3Dy
>
>   echo 10 > /proc/sys/vm/nr_hugepages
>   mkdir -p /tmp/htlb
>   mount -t hugetlbfs none /tmp/htlb
>   fallocate -l 4M /tmp/htlb/ublk_buf
>
>   dev_id=3D$(kublk add -t null --shmem_zc \
>                 --htlb /tmp/htlb/ublk_buf |
>            awk -F '[ :]' '/dev id/ {print $3}')
>
>   echo 1 > /sys/kernel/slab/radix_tree_node/failslab
>   echo Y > /sys/kernel/debug/failslab/cache-filter
>   echo Y > /sys/kernel/debug/failslab/ignore-gfp-wait
>   echo 1 > /sys/kernel/debug/failslab/interval
>   echo -1 > /sys/kernel/debug/failslab/times
>   echo 100 > /sys/kernel/debug/failslab/probability
>
>   kublk del -n "$dev_id"
>
> On the unfixed kernel the delete command was still running after 3
> seconds. Disabling failslab made it return. The fault-injection stack
> showed:
>
>   should_failslab
>   kmem_cache_alloc_lru_noprof
>   __xas_nomem
>   __xa_store
>   xa_store
>   __ublk_shmem_remove_ranges
>   ublk_cdev_rel
>   ublk_ctrl_del_dev
>
> Remove the allocation from the teardown loop. Keep the existing batch
> limit, but collect {base_pfn, nr_pages} pairs in a fixed-size stack array=
.
> Once a matching range is found, the range is erased from the maple tree
> before dropping the lock, so each successful scan makes progress without
> depending on any GFP_ATOMIC allocation.
>
> With the same failslab settings, the fixed kernel completed
> "kublk del -n $dev_id" successfully in about 45 ms.
>
> Fixes: 309e02dccf64 ("ublk: avoid unpinning pages under maple tree spinlo=
ck")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>
