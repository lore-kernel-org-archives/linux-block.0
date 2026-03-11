Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3A29B764
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207002; cv=none; b=G6uRMAhOjDnOmLhp+rsB/YFWeOvR+WkDYCdZqQmy1Av5dszFsSkhG4XY8E1wnVMzW5334OW3MBe+6DlWnkH3dV4IKr4qHJTM3PswvC1Tbf8/ekeAFlpYZtGdx0/b0jU1adla2pmyg33vTVYdyckIxJA56bHDhh9ME6wAMWlftUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207002; c=relaxed/simple;
	bh=Cl7naJDsdxKofAKL13XTAAg0NFqCf5G30oR7fQpbKvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVUSlCBG2rziBUfsoyD4Xt6IU8Nu90hvG74WidSlD1MRRGTxv/lxXpsrjaHB/FmxekiXGMrW4RHghqINNJ+3tC2L9tY5QGt1t8/P1YyO3DwcEGt8APazd0R23lHuJ4NtPt4y32IFauA0pYWum8rxVl9wbbymiYI5pkcbcEVZU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZYYxjQZb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZYYxjQZb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so150264715ad.2
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773207001; x=1773811801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpIlh++gNSqrjxti8e+fCN/v6IbpRXIC+wi7lGmEm8w=;
        b=ZYYxjQZb672J8H8bueVgQZkkVe2nlsxN9HI6km+HLy99eC9o+Yd9mCrbE7rV4hvSkx
         idHDuSqNyyWkae9+yZsth9HFzudxzo0kFYdhcDdR9I5/Uh9Xrgjn+qfekbBhLKRa10T2
         TcSWMTefrYZfjaoV89DJCNfXAtiDXA87xF/zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773207001; x=1773811801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpIlh++gNSqrjxti8e+fCN/v6IbpRXIC+wi7lGmEm8w=;
        b=bi8xog6photLTjoBJr1qG00fUUV//feEiqKa4ZU9yhYCc9F02lkNM5UeOqf4Ri9kDh
         xBVYQeJng3TLnE+9x5BMZb7EE//a6Q8v6MRZ9YR3D6sJ6FjpwaJvQMp9cLrtm5Dj/Gh7
         t9uPmilP8axAMN1sAeT2RkjsIjFSmUFT0f7bHiSMygbkmw7MWJdpBWE9F5W++wIMEm6A
         0Eari3oXpw0RJAOTtIAMJzOYsP1/3Dq4YNU4/zWHZH40o03oaFtmQzeAGfwKuy91YFC1
         8VuDHviVMymg3s4gKi0LsMK/qkoj5YZDLt2dmUQtVYryE5PSZuzM3ZmhAkLc4N59uAfD
         0SVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/RXb5RCVtmVHvgsRe5jPPRpBFKUQ+PBIZgRb6u85kIFMg3mOf9Y8GoBhj+fgTVmGaO6rqLnplmYwhpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgf6BlWlKKeTGT9NPq52Zxm1NqmFCmkxybpws2NkBj7nt6tFBs
	AZ4tjsflsLbBTaErQXSX3v8NWkFDURI4608CRqFN0MwBYdvdKAh3VuT1FPHqMeC0AAJEkwKTmwF
	aL54=
X-Gm-Gg: ATEYQzwdbi95+NWkjphXYhb59cUuhqjRY01HrDUsiuZFRdM1l4KqTeujZpmtxqMg1NK
	r3GyE8/s1gXTMBMwumxqtZwWa1yQ93OEAfVpaso9lTVsTC/T2gjVnTUNaQySb78Jkf3dzdflfmI
	Wuy/md+QPw/VErZDVKi3jpQFYNfbh4J5WQvd2nSwNQ9cVbTe0OYMsZOm/ImM51QUDeDbmrxs1HY
	LihiYvWQbdHbrzmMEA3NL9OGT/OfX/M8P7VSQ+fqT78BOHi6MuwNdXgfz5BK77q/wS0qN3oHOfj
	zAvkgdQDZ0BUzxaqr4/UGvksKcLH3WqLmTrFW6baSf32WxvV8bDaeKVtC8lOvcukhhnFiwbp+R2
	kvzWPhQyW4QHqO8Uh/ufy24QeAyBhUh+0/xw3E8qIN2Mog8BsXLbYXLrCY85gOCPQ9F0OFJnBiG
	GOR/a4GKMOcHMg9Z3q9+ETFvSi9RRMk69kRolEoNquZxsHb3goj2WSuk2Oi8hplbE=
X-Received: by 2002:a17:902:c951:b0:2ae:46df:5643 with SMTP id d9443c01a7336-2aeae763812mr14917185ad.11.1773207000953;
        Tue, 10 Mar 2026 22:30:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222a2dsm9964165ad.17.2026.03.10.22.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:30:00 -0700 (PDT)
Date: Wed, 11 Mar 2026 14:29:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 3/5] zram: recompression priority param should override
 algo
Message-ID: <abD9faU5BcoCNcfY@google.com>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
 <831636c74ca6d72317de02d96585cc6833d082e6.1772180459.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831636c74ca6d72317de02d96585cc6833d082e6.1772180459.git.senozhatsky@chromium.org>

On (26/02/27 17:21), Sergey Senozhatsky wrote:
> Recompression algorithm lookup by name is ambiguous and
> can lead to unexpected results.  The problem is that
> the system can configure the same algorithm but with
> different parameters (compression level, C/D-dicts, etc.)
> multiple times:
> 
>     [zstd clevel=3] [zstd clevel=8 dict=/etc/dict]
> 
> making it impossible to distinguish compressors by name.
> It is advised to always use "priority".  Additionally,
> override "algo" with "priority", when both params are
> provided.

I don't like this patch.  Andrew, can you drop that whole
series?  I'll send a v2.
