Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756575;
	b=I0uRcD2E4RBL5OyDSge5o0JFW9VK9V+JKq1g+30zPi5UvdBu42eJHTy7Be1N0T3LZ9Ku
	 8ZfsH1H52TiAlTtzcJwtRsM2EEXlNUOZj+3eOlTLLkGeo01g191o0kTDOj5NNknSa8pUV
	 lkRYMJg4jY6IYOnCEdi0sej2z1ATII4RNPgA4Uyiv/HzIpR1OZn3H9JE+oxqFslD7mYfT
	 CrWFzhfz6timoKEZ58QxWgqjCZhM+luNLzNCwbRcDQUP7PeuoudgZdi/tet7ptfFVnOai
	 RiVJ/E+/+5081NWFrSFUfbnm5MEpMWkcva+i0flEg2c7CLKSO6R0aAeU7o3+OfjOqmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PGbGz4TbxsRm4CnuNTXPVX7exvrpALjGesuQgwBDcN8=;
	b=WSgG3nWn1hceuh8c011LRvBpN8+Sck6Ogmq9JccXg+H2+VJdNdfV9M4hGbOpPY8ITR3o
	 qdL2SXYBCZgh2ySMr8fmLZlkv0fXGxP7RW4OreSuHRwvGdACBvXZpgPASGX6jHPGAuBqY
	 wjCfoQTfXxl3B41qbk2ciYNsQ0gyvI8L2e4Wyz68ja7UXQEZrSkpxurs7uIdgzWWu86Rn
	 JAMOEFg06G/Mr64fAIRUik1iAjwzSfAcD49wi18Qv4VjexSpiKbYtNGIjUOD5uifUl4oJ
	 yKO2vY1U0jfUX3MbkyXFKoiROrKNGkEwTNVwAedfkx9Tc/i0yL7hQ5swgtt73fodF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E1XrwkZe;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B33606A31B
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 11:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67B33606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E1XrwkZe
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so665903a91.2
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792756575; x=1793361375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGbGz4TbxsRm4CnuNTXPVX7exvrpALjGesuQgwBDcN8=;
        b=E1XrwkZeEo2dGC3AqBV58myzoL3Owtm4ZJ406k5WI59hOjxLeRup5JVLQeYT4UVExo
         h39YAWR49oAuDPKApIqQPhqV2wOIWwAU7nCguS+9e4OSUnYa+iLZbi+3Un/xdif0scsD
         7SJCqA198dK0Pi030yh8b+VlFR573YKqGgsu4t7lBy5jb9clgu6N5CG0GAKycx14+ZPj
         nMuHP0wKrfKyB6logd2crGETf3/gVRe8tMAo+Df6O7GD42+xpvFzgBlOWMZr4J3PwgDU
         GKN3AfMClxtSRjna1JWBeIjBl86ig1ynWohKqQnG761wS9FdjjmbRqUco+KytL/bMJJl
         zILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756575; x=1793361375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGbGz4TbxsRm4CnuNTXPVX7exvrpALjGesuQgwBDcN8=;
        b=jk7CXvCXaZhWmPGZcJMPGzOCYpGme3m9qs9vCTgExjfVyEbW77DhFunU/6DQDVa9Jv
         KaEVjL3Pa8cjylC6M56Hds6jSKXatZIQCcYb+JmvBf4VAE3DrW/UWxJgTVG5kUaEm7tW
         LVKefWo8Oc+HGPNJyiW5AWBlaxU+jtLaOxEGpJDhgBOLIZGZJGwW85r3S7wJ9XsgT6lt
         R5YlwlW92WzfDi7ynq/Rj6zO6HQNhJNb/FMRPyy4IjxuYAEswh/YjH09Gb2YRb3OaVRg
         lZXsbsguaKdSXuTMvwFPOfa0EZSZFxyDRyGEuwRDbxy0PuMGF8xY1mOTBDjH9eGd3OG3
         YnEA==
X-Forwarded-Encrypted: i=1; AKwUvBya/Bur4m21LenZYrOSRc169YQU9yERsxfnIWLmJ1G8dpSATy//n1IJS2j+pbfkRDtyNDq3sr7IuFQAOQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIBQ/5N5j5xxf2ui3Xs9PVakKvE8k9r0J5eB9ZAJ6UyRZQH4kOu
	vcjcNz4B9g6SJuPwAsTVhpGsfI7ztO8+oPczXMbMtvgwYPe/ETTVmK12
X-Gm-Gg: AYBFou0oxEqW2v13cGGKFsPEGve/PqHAvnwK5GFe+1mqe2GSD6gSXFGlVxuKHA3evuj
	8KilqBZ0DYvbeTzpGzkPuRZCg6D/5A2xsXdZED6EUEC85WJ2nT6UtBNXps6OoqaHbpmxQjuLsP5
	00PQPPih39U1v7n/OIxmMMgtAMILJwfhCuO+L928QLLaj4JTJotKvbPnFMAZdmI7fIGU1EOD2Sd
	NqQVnCPg7pkigWn8r/jP9Y6eQu4U4rI5VEeipHaW+ea1bY0uMQSADmIp9+velNBK7OTcZhxCoXH
	1wyi6xzLkTaG6nI+D896cSHMn+SOmpUyyOKAurpGgubQn4yYPk5hfTeGWyUVDjr6eWuQguItoTD
	vnT4iOnWlL8ZmjJijkNtU6/jBFjcBXai3Dv2pfrO9UuDoS23p5ON6WHO+YQP77ftlAYHDLL7AHM
	kiobd6rbBtufEsMrENPv3sxbSlktgViCFxLsp/EOmR32NEX+Gl5eblOdluaX4Q7EkM7IwCiWL3e
	3/hUUNA2cQW4d0Y9nS0uvXYSwtiPuD7orC2eNa9gpJGY6EiFZOFYRD7
X-Received: by 2002:a17:90b:518d:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3adce150aa0mr1524440a91.57.1792756574675;
        Fri, 23 Oct 2026 04:56:14 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7ae0:50::498:6a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addd73c20csm11163a91.17.2026.10.23.04.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:56:14 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH v3] block: annotate lockless task ioprio accesses
Date: Fri, 23 Oct 2026 18:56:09 +0700
Message-ID: <20261023115609.12244-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
References: <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Damien,

Title: agreed, I'll change it (v4 below).

On the pairing: a release store pairs with any load that is ordered after
the pointer load, and here the ordering comes from the address dependency,
not from an acquire.  The only thing the reader does with the loaded
pointer is dereference it (ioc->ioprio), and the kernel memory model orders
a dependent load after the READ_ONCE() that produced its address.  This is
the same pairing as rcu_assign_pointer()/rcu_dereference() (see "ADDRESS
DEPENDENCY" in Documentation/memory-barriers.txt); READ_ONCE() also carries
the extra barrier Alpha needs (arch/alpha/include/asm/rwonce.h).
smp_load_acquire() would only be needed if the reader looked at data not
dependent on the pointer, and would add a barrier on arm64/powerpc for
nothing.

Why not plain WRITE_ONCE(): it would silence KCSAN, but it does not order
the initialization of the new io_context (alloc_io_context() runs before
task_lock(), and spin_lock() is only an acquire, so those stores may be
reordered after the pointer store on weakly ordered CPUs). A reader could
then see the pointer without seeing the initialized ioc. The release is
what makes the publication safe.

If you'd rather keep this minimal, I can drop the release and use
WRITE_ONCE(), but I think the release is the correct thing to have.

v4 follows with the new title and a comment/commit-message paragraph
explaining the above.

Thanks,
Nguyen Ngoc Thang
