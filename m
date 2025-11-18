Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BD1DC985
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432092; cv=none; b=lj86woZU/yWw8hkPWkuz2UBOXf+049aS3xIf8aF6IuZmoh+y/RAY1mG6aAg0p+DiYquGGp5bQ/hBEARsfpkePpJsWJnYwN/9Hnhn3S+862sbdzZVO5inDedl5T9Cvg44EXqedDCe5YGsnOxCsigjxGuEQCyvfzWsb8GjwxAtFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432092; c=relaxed/simple;
	bh=Y6k6QIWXKNdEDX219gK0UJwi/R2H4jlzoXyvnxvwbxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTIEBbnc/KNnjX2X5yZLWbyyIKwUUY6GX5TBXBVv7Z5XGfuTq921cgFX4KdfOI07Nc9UdoCVc8j5sPxdEE+PYet95Lmh8w3Cp/gNvJezyNOBTgHod9U+ZEXd2dk1KpMC7PGldLrmJQYn0z6TVhMQkh0/Khsglmkicp+chBap7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uyr5PB8T; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uyr5PB8T"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso5112204b3a.2
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763432090; x=1764036890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sQZXbj1YdX31C03O4RWI6hvbK1qocJ5NOHys4I9+yw=;
        b=Uyr5PB8TebAPbEkihmTmGi7Fi5NHnBLBwY8fYQThfeJL0kP8WF7tp3z7BXmn3gGjYW
         eYA3hB89AvJf8FbagdOFBPdVeW0+dg/OEQudArmbvmF0D3YO8duoeJD8WhWoXuNPWFyL
         HKgoX1ekL9dFxYXH2wULi6JCmFZt6MTZAR7lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432090; x=1764036890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sQZXbj1YdX31C03O4RWI6hvbK1qocJ5NOHys4I9+yw=;
        b=paoZYB9AHH+CpB6vL/r/1EHefM2YioFtx9oDx9Pi6NiS4V/0WbC2CFg4ETv/X52uoA
         kukwNtz4EwHLeXnU634sh5TbJTLppQ8Xc7Z2LG3+WhJOCBfsNpNUtSK784JrZ5cS2kiE
         jsI8WaaSijVSZhweEpkEG5LGPc71/kwbjdSue1P+Oex8hqUo0SgBFwmyLP+NyEEtCSSF
         rqo4IHO9h8JJgC3FjzCjIPzbRZYDjrd+J1dQIL8EJnynvMY+Xw7Don1C1wxNddhdR9rT
         YmTieaw5Rp/jqE0eRhW+gG/KTkYp+gD7N5b+jVMicETCGQKSGeFLVRkKPGquOnQnnuyc
         QL6A==
X-Forwarded-Encrypted: i=1; AJvYcCU+YaVIBKUkMXiJ+1v7g+CuEMc9ieBKNl6w+2cBq/o7gTW2OLUAJ6jkAnz4saMO/PXLeqxs6hQ/IntjcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxygQOJb0US67mMfgCFdzSkPhGf9c9UNKStTHDhdOO2/iNniaTs
	41qRYZ84INHGNve4MM46pHEvS5KTj3XUmQu0aGGj3CtJ62jMrtPPou5ddLnlAZE7AQ==
X-Gm-Gg: ASbGncv2vo1j8u0vFoQQ+v7mQNfdVAsNZTNxZrn7V44Rn1gUbDDbM+DNvW8XbnMcome
	uojAgi4oBcTir4Dr13nZPRcCgmmjLiMVUiKSR/sRj87ZDZKtonDSTkwmPTpeMpFgjufYcaSNXTd
	Vz49/QkYbfAXGkNWgIpeYIrjEWnT/9UAvcgL/nzZzCImEJbDR1QB+0aGWidy71OuOITNK3Zavwd
	XR8kp0257obYrByV4MD/FWkk/sSvMci8fPNof5VdWOxovp2Zp3WFXIkj4a0JfQ8SOrQSmTRpfJB
	e31OBQ2pSf9c37BUQGrOUtrqTOq/+wLArp4CJmhG9Cv7GcaBfYcY7H3aMVM58qnrytQ2dlwqH7Q
	IEbtPJ75OwepXP47fGGgcBXrXt/h+Fksw95QKbqIdng05MhilK0cXo8od2TmIRfVNg5DqNOOAWg
	cBCjW9dEfxCGs5OeFdegHW/F0GXA==
X-Google-Smtp-Source: AGHT+IFnhFnm/WfC6A+BHWhwAiIZ6Bgw+D4M+jdgTMpC0ZuxdGNC3uhzeJpEWoMZ+hyyVF9I1M6Tvg==
X-Received: by 2002:a05:6a20:258b:b0:35e:c55b:9203 with SMTP id adf61e73a8af0-35ec55ba46bmr7643528637.33.1763432089994;
        Mon, 17 Nov 2025 18:14:49 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:54de:ef1f:fc04:3ba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea0f8sm14739557b3a.5.2025.11.17.18.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:14:49 -0800 (PST)
Date: Tue, 18 Nov 2025 11:14:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: bgeffon@google.com, akpm@linux-foundation.org, licayy@outlook.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	minchan@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Message-ID: <3nqzi2v72dsef2dte7iqe7wahrbzam33druh7klsh45zvefdm3@ab6stznzdxmh>
References: <CADyq12zxzi+t727B5sm5z-z3SmRQyMDOmr_tTG1GaMVh6VTWbw@mail.gmail.com>
 <tencent_547137D7C2F3EDBCD52FB12EE2A202EEE307@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_547137D7C2F3EDBCD52FB12EE2A202EEE307@qq.com>

On (25/11/18 10:08), Yuwen Chen wrote:
> On Mon, 17 Nov 2025 10:19:22 -0500, Sergey Senozhatsky wrote:
> - index = pps->index;
>   zram_slot_lock(zram, index);

D'oh, indeed. Thanks for spotting this.
