Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144711A9FB0
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710355; cv=none; b=CBbWT27RWNXKGyHFVmVWYkq8Dd4l+X7Qg4B+e2kUXbKFIVMqQfGIpBAlKvGcoPLxL+10U4+FGmBMHzfG5kHWkTxvGTNbuT/sdaM0McqeK7iYwqrsAlyIjV8AVFWnZWdGEzL26DeVdQIihful3tN40xYuLdJl/Sd0wQqKnYQmmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710355; c=relaxed/simple;
	bh=M04LdZMUSCc07AbM5lTLGaDjy07TBs4RlYBazrY5EHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPOJv8gBXzXz8ozfZpEmvPYqxGu0ZOoK6ubSwjsbnGCOGcKAx89MAmQNZixce2dj5ROVYn8wdaKZqW+yyzNjLHGzE6DBVxI9jhSqeW3OfZe00yBfPKhymZC6dIym8X/DeyKWjgnKBzAyrjmynnhmMvqi7bdfpr1nPxKi1ZVuBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dPL9udmT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dPL9udmT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so1379606a91.2
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 23:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763710353; x=1764315153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eP4FxARObWS9vkRJqC7sV2sVfLC5TMvEe3NqnVYi/Jk=;
        b=dPL9udmTVhIB76xPPNNouyQe21+U2Gf6QVEAFDRg385pRaQJDwmePslCwtvs3BvFSa
         Ovorz71Lkhmh7e/5jo9Q2cneVmD1y99RiWZ7eApLI8OpJxzSwZKogApJ6Tp7RJHHWl72
         hGPw+nuzz0A6/KhSWZhgIcY02dcZW6J9vG+2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763710353; x=1764315153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP4FxARObWS9vkRJqC7sV2sVfLC5TMvEe3NqnVYi/Jk=;
        b=mBePkwQVqSleDdlJ7CHzelUkc5PKoETlmRvwEQkT/NvQrgdjaFXBcBiG8n817A8y7V
         2nOQVoxXGC7Fh3Ogv6Il3mPkmDK4Q5eoHhcRYUi1zodcIyjwgCtglO2MEc/63+nsjfpG
         U0Nlot57TO7CSXPY5lXFtUT0txJ43Zqyhw/y4ZFEvEYPNxph5eYqXmvV4kx9aSaUAiYd
         /9kXcWYSUfZFI8hWD19ikw616Yp8MS6y2JQTW5hUSZpxV11lpyiNU7mWZm45OBs+m5x2
         om88yqOcxh+gPiRpV9SGxsS6ExCVEnivmQGKR0zgFLPyW8nJa6Zn9gVKkPtqV7UBlLt9
         in2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHT2cVt2lTXCIFd+xvQEeuw4um6juQXbKpiLLFYY52FA/hQ4fv+teVeI8dBGA+wQkJG92jxWU2E36TCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbU7ZJlTpInFfu8v5YBOxL4MkCnE8n3fk2sFROK6heFN5ljMy
	n0Vj+vGlPpZOfkNr2d4gtIv/eldjjvIxG7SLxi6L8P2rX4+9Eq/GriE+K8odFVa/8g==
X-Gm-Gg: ASbGnct+L1jT18lfuTa1p5CQPkwQktpa+KCZX4EAQ+opm5OaN8k8sHpulHxJ1Exg7F4
	5vlo6sMok8CahfH5IrNZyuesNEQYCpcMACMPgqItC3O+WCtWhQ9I+bj/M0Le1aizVCiOEYm0sou
	oNU9OjkgIunpWjd2CjISWxGnbiPN4yjVuv/jYUa7LHFnjs+S08rtmfKE4SkLKokOiHMvmQetCRf
	8foHwB9yNnwdDj/6vbujI84p1giXHvxn2xcnMJDIM+TV9M9FX7uDmbLXrEjds86ALltjSp1rZ52
	o+O400R1fkbmXSAf66ellTAZdQYeRs3SAUYNUqwWvLXGr2jGytb9o5qKhdPT7lNV0vBrkvJeBEB
	H4z1CL0oRfMWL4u9gpr/2ifJoK6CwHoKF8poKdausW6ev/cz03UUcsF+uRmxTScQlOb7p4YCueM
	2RKhxGUgjN+nTlrg==
X-Google-Smtp-Source: AGHT+IFBREOiOEZ7qBgrF54NMyKPzD+NC9b8oN3uY8MHWRRQbBF1pojjanpzzM8yrsl4GI/fnBPTuw==
X-Received: by 2002:a17:90b:580c:b0:341:8491:472a with SMTP id 98e67ed59e1d1-34733e4c8d9mr1759968a91.4.1763710353227;
        Thu, 20 Nov 2025 23:32:33 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af1ed1e7sm5529337a91.1.2025.11.20.23.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:32:32 -0800 (PST)
Date: Fri, 21 Nov 2025 16:32:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <upyms2wnksojg6ix7dha74bjm2gfhv6ieef65k3f2our4r6fp4@kjtpmu4mtbay>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
 <tencent_301571E78C8FB8CE9FE3E5857DC174E5150A@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_301571E78C8FB8CE9FE3E5857DC174E5150A@qq.com>

On (25/11/21 15:14), Yuwen Chen wrote:
> On Fri, 21 Nov 2025 00:21:20 +0900, Sergey Senozhatsky wrote:
> > This is a different approach compared to [1].  Instead of
> > using blk plug API to batch writeback bios, we just keep
> > submitting them and track available of done/idle requests
> > (we still use a pool of requests, to put a constraint on
> > memory usage).  The intuition is that blk plug API is good
> > for sequential IO patterns, but zram writeback is more
> > likely to use random IO patterns.
> 
> > I only did minimal testing so far (in a VM).  More testing
> > (on real H/W) is needed, any help is highly appreciated.
> 
> I conducted a test on an NVMe host. When all requests were random,
> this fix was indeed a bit faster than the previous one.

Is "before" blk-plug based approach and "after" this new approach?

> before:
> real	0m0.261s
> user	0m0.000s
> sys	0m0.243s
> 
> real	0m0.260s
> user	0m0.000s
> sys	0m0.244s
> 
> real	0m0.259s
> user	0m0.000s
> sys	0m0.243s
> 
> after:
> real	0m0.322s
> user	0m0.000s
> sys	0m0.214s
> 
> real	0m0.326s
> user	0m0.000s
> sys	0m0.206s
> 
> real	0m0.325s
> user	0m0.000s
> sys	0m0.215s

Hmm that's less than was anticipated.
