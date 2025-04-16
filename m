Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF6202C38
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765454; cv=none; b=LpuY9r50sr4zNkhuKbwUpHMJlXndq4Lwh1YAzAP7vc8+zVn4v0LwC1y+G3SGjwWeYQ9t5BiuZ3Z+B+gj0zCaWidF1+L8e2Vdrzf/cxvN1CWt/CY87NaNxkswSgUbMcSsfXIvZeVEcvnASdvVEG19SQaRVSBqfVoK+mUWVfTYF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765454; c=relaxed/simple;
	bh=tPIIDWCtvCMUi0dba5wS/vnKRpQYieJRvDzGuUpS2cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtyXai0sRSVjVQfbp2zTONQPGOYMemKAPzqJ4YjwE1PquvWV7A4dts4LLDz0gtKYXTFzkWN6YV7WBPALAO98NY08KitJC0ZSl1VfKhUofK5On2rR0ZQSAz0FbLu2mttwpSHKMOWWqs4A6ybG7S3LfsxHm6qFAIwvbNlVyKacH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eAgaZS00; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eAgaZS00"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85e15dc8035so204178139f.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744765451; x=1745370251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOzygePW3310tVx7kEfO3x/NC5w6EQLjdhpFeXqXF04=;
        b=eAgaZS00Pv3pt+zm9nWLIo3Md/3MzJGcu7IEemdvbWpI7g/8GnXXX/9prjIrmZFNpp
         Yx4Htw3VJhzm7BtnAouIJxzAXGlZuFJIGChlAoN46/bEoFz0G1ccPFudxVd8oje4laAH
         z3B4qOUSqaxLNk0XssFvCcgGCvLwX2n0Or2XiASfBdJgF0WyJrYeXWMqL5qSw3OkgE0G
         ukMafe5GVGmEPlKGGQorH4xV7r0kR3cFxk6Mm6u7swaqflBIfofITIba8V6KsqrxDgAA
         6GOwl147a/5l+fIQF1AuyL13ayaZsPTxa0ZYQ9oi7yL6U4nkxoQGUaRJ7e2g1ZRM+iOH
         pU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765451; x=1745370251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOzygePW3310tVx7kEfO3x/NC5w6EQLjdhpFeXqXF04=;
        b=r1No0hC/ohiQy6VMYjrf/6c9t0x/iUeI2iQQxsgAXQWplhf7RLIDFAlS+q+JNuX3i6
         YI+0ZyEt8TQQd4R2JJmoOBWJwYYMRG2SU94+vFW3gVWsIoZdmobB/pQtbCJIG0xEbagW
         WT8zs2tvLHkoXwoebNcXywsNjJuO3kMK4Y0Gi58Fkd8LAHR2N4M1WeCQ0hUoKyloKbdF
         0PlY0e0qFMKqxZjI+S1xH5nS2svoU24gpT94U0yDOwSs9wRnXNTikZsNedI6hdNLsFy8
         DAD0rmdnAs/VUMf3yjDbx+cwzLARs6qXpj7I0Z/p3cAfwqHJ9BiXejPKlMs+sycz7OaX
         41mQ==
X-Gm-Message-State: AOJu0YyQZIYil5ZIJ3wEOa6ncUMa2IbJAtJgeEGRDgn4Jvk2L8CuTDW9
	IBovfgI2tC2jQZsBVz1jcGc7g/CKh5DNxXCETpP771xNz3T26mz143UB9t0xKzA=
X-Gm-Gg: ASbGnctCGSC/UwFI9yYSwTuegs0y66xRBTyHSXWokWhqd/6WNAccfunjv1XitOXfbOq
	KO5jXxyV/gM0kcW0JpTSKMI7V+mxW1X90UAOGsQruANwrwvurc3+eEu/9YXUHENeSRHT103sDEt
	UKad5MIobMBpq+O0xCLP2B22j+5SfiWg+kB1luB6WjIXr9/uQulOT3wUrbksCOGEgyqoAUXZeBt
	IVAXxIXf1PaXGwu/jhfM2qDWZLGcqafyKx0macKd1Qwsx4KMkBnP+bCoHXcYeD4gKJXoKFLyAJO
	XOlSFY9zSuKf6v8KVgTGIWwCHl4Ws8U0Bw1+fQ==
X-Google-Smtp-Source: AGHT+IEHI5YXtsH3GtE+xAxjPnoEaxwITdOpITzfsT2ZontVDQfoJEe0M8gxlFjwjY706Hy1dO+lEg==
X-Received: by 2002:a05:6602:360f:b0:85e:8583:adc8 with SMTP id ca18e2360f4ac-861bfbbd3d6mr192307839f.3.1744765451183;
        Tue, 15 Apr 2025 18:04:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522cf6bsm275091139f.7.2025.04.15.18.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 18:04:10 -0700 (PDT)
Message-ID: <15e2151a-d788-48eb-8588-1d9a930c64dd@kernel.dk>
Date: Tue, 15 Apr 2025 19:04:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] pcache: Persistent Memory Cache for Block
 Devices
To: Dan Williams <dan.j.williams@intel.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, hch@lst.de,
 gregory.price@memverge.com, John@groves.net, Jonathan.Cameron@huawei.com,
 bbhushan2@marvell.com, chaitanyak@nvidia.com, rdunlap@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <20250414014505.20477-1-dongsheng.yang@linux.dev>
 <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 12:00 PM, Dan Williams wrote:
> Thanks for making the comparison chart. The immediate question this
> raises is why not add "multi-tree per backend", "log structured
> writeback", "readcache", and "CRC" support to dm-writecache?
> device-mapper is everywhere, has a long track record, and enhancing it
> immediately engages a community of folks in this space.

Strongly agree.

-- 
Jens Axboe
