Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8A1922FA
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215611; cv=none; b=G1WAQ6DYSZfqvb3zSoEwPtJUA7oCwdqUeNMQG6lsYoYpuOX50TPjOnP6cNaCVUyZckdxfk44cjJY/DiJiVnzgZI9jczsHyMY3N5IfMHs2Uy7MvHplmbhU0V6rZfDBRoSeEwQiEDglFOaELHcWQ+7ik8rmJ1mhj1gPx5GJUyyQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215611; c=relaxed/simple;
	bh=MP05C+LLsi4lyi7eXWvekWSCe7+VEN5JKP9djRfnCDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DITTBawmS3J9slrhdQdyhkdKGLRAVB+jrtARfpf0ZYHBM7IfAkONREgabmndvmnoXLeZwGWmHKdq7RZ6PZCVpHBZUS5Hc3Jwb+wIk1YkJOYaf9wOn7E4phWNYizJA4WlCdgn1S1g2BK7i76ktuR5r+qEAx7xWBfQE4M28x8Rqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0ZWN+hjB; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0ZWN+hjB"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so224465939f.2
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730215608; x=1730820408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4pGDTSYlBNSPSCGgIyD1gzrG+lI3ekznbxiZaTSYjk=;
        b=0ZWN+hjBKRIZifjB3aCpVT4QZ6cDzdf2QLDZCzejRowFqwl3Ve9UU8FTCNTgUGFP24
         VX2u7mhwZNnfc3nWxLLLmB61bPCwQ9pkCnP2+ROgSvmeIX5AZ+YOuRmTlIA2BJC8nUnz
         ljqdqG0Sj/7hmM4RWPhw/mp81IWdaDNWyB4Z4uIHHHZXBZ7Qw+45u0ySKpLqXI0qpowd
         Sm4t5D4Qz9ZHxKWgYVcKyQvGrMxcMow+VXzbt6kW9pEmLmfELdzM4BKWB08g/k4ZGjxe
         nXG54dC5IHSajKVvphdRAxUjxjFfpHDl8qEWE1wQfHkS5AIBdMqKZLmWK4mKlajTpwQa
         vanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215608; x=1730820408;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4pGDTSYlBNSPSCGgIyD1gzrG+lI3ekznbxiZaTSYjk=;
        b=Twm474MrZnCQBsPEgustmOkyTT0+IE2SbVF9HY5Ik0uLRdoi3VszULi852eNbW48pI
         qMpKN5TkA9pkaH7sxTUkji9e0Ff0oxvtRg/QTlcqcejS7QjxKV0Zr60kh9oIJZz5j2tP
         gFUHipf2M3xJLRdA2DUvMO4wAKNHjob5LMUGgbrpwlPEkNDtIuAja9Ib8amWnwHJNg3D
         j5wOu2TBPEP/aacPfLyB1qKBUW9HB6kmcemEE2OKNJeb67pJwFj1IrUgseswFBnagkKY
         osoDX/u5sJKsfInQeaGyINDURs+x6fVwacG0f2Vt5LrIieumyJl6UaauNFF204rzlnQq
         /RfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx7qd4luGZX5ZyGDSFnZQ9xsIwQK0fMwNTVBAuh6bjPiwP80RdsUyBdPbGJWCpfokPC4nn8M/Mm9uaVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvQEGsV04sdgKBvZ+Lqhgatu1ZpQdRkSkDqf4aCOPADGb2wLd
	4IvgB1Wiw92ocYTSinF0wFtuAQEiftDAPEpsCu1S0jV3hMQZ4x48whrveRhdkHXrYRZTUOh5jlK
	z
X-Google-Smtp-Source: AGHT+IHRYe/p+k0FqYDYKmOjmUzaVgJNcjwECu2Tdmh1c6a383f/H3ecwU8M6t/IAMkzG1/Nka9odw==
X-Received: by 2002:a05:6602:27d0:b0:83a:cc2b:c9ce with SMTP id ca18e2360f4ac-83b1c3dc1f0mr1616686139f.5.1730215608409;
        Tue, 29 Oct 2024 08:26:48 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727b17cbsm2461640173.171.2024.10.29.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:26:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ming.lei@redhat.com
In-Reply-To: <20241024050021.627350-1-hch@lst.de>
References: <20241024050021.627350-1-hch@lst.de>
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-Id: <173021560756.667860.15090283089196226364.b4-ty@kernel.dk>
Date: Tue, 29 Oct 2024 09:26:47 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 24 Oct 2024 07:00:15 +0200, Christoph Hellwig wrote:
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
> 
> 
> [...]

Applied, thanks!

[1/1] iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages
      (no commit info)

Best regards,
-- 
Jens Axboe



