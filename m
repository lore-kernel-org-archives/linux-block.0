Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857213957E
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069349; cv=none; b=Y9cRzSAY8/V2cuFEP4YxpBbOQ1dsjtsRgxCceyLGbRrfARed7MEvX5WRdqwLxVqea/rS+h2bKmNJTpniOfEQQwFtx3+XNvSuhPRcJVc1q5P/d3emcABO2PJfXbrUhjUKORsBf9v1w0KsZ1nciLoUzybXnAEs4B5uEpP29WOvQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069349; c=relaxed/simple;
	bh=L8phg8Yd0a8z0cJtU511m+EDzsT+ImjO6rzk1+SZ1CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atgrrOPqdpeKPfzxwdLe5xcDTQuqq0pn4F5rV2WNqfWkJI7/H175cHdA3l6hpQ+7TWMVKQhCOMja+qZA1/ok/BIKTiWU8NtC0i5MslKpoDOUt6/zdEo6nUhG5pzKasZuijg+Mr4PAlggYKRut6iAbxmrnhXlrR1R98D7G7NNoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fEJ3VkAV; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fEJ3VkAV"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-267a5aeb9f1so17284605ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758069347; x=1758674147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbI8L9M4JYXwDBQdPDmo55hFH7biVlrOkrfO/tfqIAg=;
        b=fEJ3VkAV4tAePxhBWANbdMBRIuG6tOVI/78Knllr+QP04AiZJ+nrBDvEp31BasMTyU
         Y+j0VBIwYVDV4CFVR7mFmoxpy0qfc6qZOR0+U07gnS+3AoPOmcNgzHMj/TdV2ED9d1hs
         4i3qthqegoY2NnzksO2tvsoI1Ocz3Ll72oayQx+YJiM1G/Qss+9Uv8INbY2VXEwYt9Dq
         m/spOD8I4JwFaeCKBgp/2nmynufp1WwGqaOhAArMNSR41C8DvZ4WITxgxjcIKrNtqNnD
         4IhOLHs1aA5uvX6I24dLj9McbejwiLLSyBRj3lU3AQkcLc6EhdOeLXTkFq9poEb4oMWX
         HsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069347; x=1758674147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbI8L9M4JYXwDBQdPDmo55hFH7biVlrOkrfO/tfqIAg=;
        b=lzmKbeu+jZGgFc0r9ZV103OG2ke/hZydBDF76nmuZI5H/HfWlKUEzvU9XsizpJ6MAB
         dQc6nXLbVS7bcti/MLxPOZeZsPcM1MfkLTMoXfC98QJDo7fKObRSHQrs8iDWHnx3wouc
         5+9EoCAuuzGQhUWwJq3UQNnOrNEoFJXCq/sZDlD/2A2554WJ+vIIjkKOCVPyzPUbBPus
         ST0ECTZ/DcIVaJg0l5/hdILhEtBU5clPMnpePrHmHVTN8UMcbBIGhhKSCL9sUxmdwaJM
         I1qwH5joX0yKOFhZQRg4wOPN4s7TDLXakoO+4VT7X+UBVkPxKSz+5hqG8a/5N2DNc+zC
         xzUg==
X-Gm-Message-State: AOJu0YxO8yFVho8UFvhTevWh5Z7d5oLMoLaqkz50SPJIdJLg/58PFnLE
	EBgvikNI0zaGEdg2cC0mUs/rDBi8ztIofQIEp2RI5FTg/N2fHQkfJ72N/AvJyy3c+PHKxx6YaBx
	b4DzdI+w5clxxgP6QAkRhMBhyh5g2qa8a7cewj3xSY6+fwlLcaJyg
X-Gm-Gg: ASbGncvfou679e2Rc9gAUnTJuzD8k5+qBQvn08i4U/3FlPnmSGgTvVJIdTe8/BzzqoK
	tNv1J/FblgZ95XoqlN/Wgj7DxQDE2P4KidRyuGgmLFwIsYk7d4bafktYyBCwRleoL5vqC3ddmDg
	idBnS+bT3198XlZvCfVqLEE/P/w/1sP6Dx8VKkUZA+Qc5BHhGFg9g6ZFOKCHfMeq+8cuyT5eZzp
	RkNJMBRladQINoULMMIzNJmB+YzS4TpVfeogMdwruiDLzcJ3wPCQDxwgF1738IU65i5KuF7goAl
	SAYjJ1Px7Nerz0JciHqhO7P67OonYflMGmj9f8u2NzeLXJlnfvohH005Jbc=
X-Google-Smtp-Source: AGHT+IEiIDXkSrx5GtdhuqYIDr1VIfuMjIQs0tgYZcUIgrXb9WrfiLPKfhN0RTcxZ2Cl9VKZoSsr0L7/MMXA
X-Received: by 2002:a17:903:3d05:b0:267:44e6:11dd with SMTP id d9443c01a7336-26813bf0cb6mr2254435ad.53.1758069347404;
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-267b5deb158sm4934865ad.46.2025.09.16.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AED7E3402ED;
	Tue, 16 Sep 2025 18:35:46 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9240BE40EC3; Tue, 16 Sep 2025 18:35:46 -0600 (MDT)
Date: Tue, 16 Sep 2025 18:35:46 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: fix behavior when fio is not installed
Message-ID: <aMoCYseJUVcbC7gl@dev-ushankar.dev.purestorage.com>
References: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>

On Tue, Sep 16, 2025 at 04:11:53PM -0600, Uday Shankar wrote:
> Some ublk selftests have strange behavior when fio is not installed.
> While most tests behave correctly (run if they don't need fio, or skip
> if they need fio), the following tests have different behavior:
> 
> - test_null_01 and test_null_02 try to run fio without checking if it
>   exists first, and fail on any failure of the fio command (including
>   "fio command not found"). So these tests fail when they should skip.
> - test_stress_05 runs fio without checking if it exists first, but
>   doesn't fail on fio command failure. This test passes, but that pass
>   is misleading as the test doesn't do anything useful without fio
>   installed. So this test passes when it should skip.
> 
> Fix these issues by adding _have_program fio checks to the top of all
> three of these tests.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Please disregard; it was pointed out to me that I missed a few tests.
Will post an updated v2 soon.

