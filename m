Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F62E40E
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130943; cv=none; b=MfhssPmoy6xIrsIge4D+TsTsXoKIHoH45NXAAAo1lPnbuxWb+ERhdRZGrC/jKAw6SkwlT/3oeMKYt9KVgfFV8J7Z1zgfM46xaTRcTeV2mTWKqRMhQKeaj3bFYK6RSVmv2BvpmJjemWFHgGsHrn302BiFwR5oPmSRqH33iQcXS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130943; c=relaxed/simple;
	bh=uuU17LqMiV4IAFVN+4Ez+vDlX24XbFN/eQfiXdz1JTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzK9OipU6u5zAZz/zCtZgNQqXrag4QTGPjALj43VrR24cKCNP/dR79lZitmWU1UIsf0IBL3Lxl5x+fX46K9u/jnYBClajIGJtsVilzOJzvP31TLGwaQGr4gOm/1q9gkAalbHh0GGP4ngc6gv5p3PT0O4FOikZ9febPmB0yModbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=S3MFZdF8; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="S3MFZdF8"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86d0c598433so28588139f.3
        for <linux-block@vger.kernel.org>; Thu, 05 Jun 2025 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749130938; x=1749735738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pI8D5AUkm60Fo75qRERIbbgYVvFQrrXFj50MSrANZI4=;
        b=S3MFZdF8aimJVHZbPUTiqX1DhlW0dWXR7ghhiHG5NTBSR0rOAtSUheIiWMWbPWLAsH
         MwgcgSoMvV7eiq1qxfOlBT8azks6rMyBIwJrttyRTAH3spUTa4gi/pjMCry4wM8IViZQ
         TzEbQoTSNgxH0h2AUsliJrotAiCC6I6V+s7W48tuqSMk76PHe/iRX31BoPBGeVavPxc0
         MjC9wQKucmlSrifWVBg6M226BeEqv+VuBKxQl36lBrVlX2evz5Tso/qWCH3A8DKXZRQR
         +o7FLMvGTjVoNxEggLP208OwmBch2+ohb7cDs0AYWVRSJJB+cj+KvWTbKMggBmqSjnO3
         vOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130938; x=1749735738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI8D5AUkm60Fo75qRERIbbgYVvFQrrXFj50MSrANZI4=;
        b=O4tKQ9PsJ0bN6WIO9AkQAZx/sJTFc3U/+EQB3hmE0mTDuUn1GyV3WOVPKfA0yHCepq
         pL1h/FrutDddF7ZAgu8hWgRq759Zx8C10yr+FE+ca43W37Hlz5lllsROUUv41WFPRYZh
         zgPsGUnOItGHqNQXOl5T1g08qeKVfnA+TX0iG07eJQYMW6FgH+BprEQ1NdSp12tOq/72
         qit68Uu1MPGmnnf0SY08h0hHHQAHVfw3hOtRD0/kTVCQlWHs7jlI8/gADGQwLOYupvR1
         aJLieU/wPfHQ9UgOPygAB46z98JXJhSMZc/AEH82xXAyrN4o5NPtdUn/mMv6qVouZm1R
         4ECg==
X-Gm-Message-State: AOJu0YzG4aglkotCPDYzJKydyNcT9NZH8vUEaqNsLoE2gt42Qap6yqsE
	9ML/BpleEF4BdqVx4bA45nI/5z9AT/7gtd1sihbYJbxBfH0WJlzXo8nhuLSg995zA4s=
X-Gm-Gg: ASbGncsnZzfixZIUgtT0D+tOmIKHVhqkANhvZePi+xWU9wbPueEeGdWSlm/Xv62A0oL
	CQN7LQDwptiIqwSVhPPGFin++Hqy7JI3TgjoyTenbYyJsViTN5ol5J909ueJJUNRrXvfKxiiLUL
	qwkRpDXoeiGQE5FNc1vHy2u1jRje35hlF5adiNuqkRH5qucgITRu8vUicek0gxr8XOLEyfXXkbs
	o+bo6hPFiZdpbmzFGhQnZ7wkH+8QK5jWb4OloTyBvkRArmrB6eYQhTIbM8Cx6xRoZOm+BbWeHv9
	WuQXeQyBWvJSeHLurbe1d9zmEEb/TcnILlQGdtR8rVbQGsU=
X-Google-Smtp-Source: AGHT+IGNhE4Q/55V5nWoOcc9q6/ny7tf0HY4NW3rcwPvzDDBGap67w67idXKdSn7t3obEfaI1RhzlA==
X-Received: by 2002:a05:6602:7218:b0:873:f22:92fb with SMTP id ca18e2360f4ac-8731c502c2fmr826279339f.1.1749130937774;
        Thu, 05 Jun 2025 06:42:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7efce43sm3296048173.117.2025.06.05.06.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:42:17 -0700 (PDT)
Message-ID: <cd702850-63b3-423b-b883-7b3737ef5e83@kernel.dk>
Date: Thu, 5 Jun 2025 07:42:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aEFkj8jfrDVGuG4_@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aEFkj8jfrDVGuG4_@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/25 3:34 AM, Christoph Hellwig wrote:
> The following changes since commit a2f4c1ae163b815dc81e3cab97c3149fdc6639e3:
> 
>   selftests: ublk: kublk: improve behavior on init failure (2025-06-03 20:19:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-05
> 
> for you to fetch changes up to 44e479d7202070c3bc7f084a4951ee8689769f71:
> 
>   nvme: spelling fixes (2025-06-04 10:23:28 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.16
> 
>  - TCP error handling fix (Shin'ichiro Kawasaki)
>  - TCP I/O stall handling fixes (Hannes Reinecke)
>  - fix command limits status code (Keith Busch)
>  - support vectored buffers also for passthrough (Pavel Begunkov)
>  - spelling fixes (Yi Zhang)

Pulled, thanks.

-- 
Jens Axboe

