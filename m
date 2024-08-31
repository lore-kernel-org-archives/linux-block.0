Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DF58ABF;
	Sat, 31 Aug 2024 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725135346; cv=none; b=HlmNQAWHxZyxCGjbCUq/u4IPl0DHZ8xvPre//EitPCjh9zeJWM0cRCZjWAJAyQZVqf2MVLd8XosdhuePaA2jvLEZdxNd+z+3H+ibsAz9KQSjA6H4AzvgFtZNkUsUOWEF7gaCMUKJtZQLN0qU7oSQogA1Ihv0OvuRRjE7dxDe1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725135346; c=relaxed/simple;
	bh=fTd3Rkisp+jqBhvh8TXsMHYe+fo3OUcH5plCUvNzbe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ip7kyiV6rc58XoVVVIegWkR2sGG4VxAKtJ17BmHjRZQQonOaN4cNHVIGODfhISVg1SQWS2+7ksHAmo+DjCWmofcPy6j1KWyRKgwcpyja6TA57ZF2tePJdTip9gThic8Oga8ALsNp3UOVavle6odfmpatmpd8Ilra1ql/XeOIPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liW3O67X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liW3O67X"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86883231b4so337218566b.3;
        Sat, 31 Aug 2024 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725135344; x=1725740144; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjEEVYrxI6QjBkSeZM7AgitlYe2hgNyzH0COYIgadzQ=;
        b=liW3O67XxU/gxp3sCBlTD9Nwy4orHLzoBWP26sRW1Y+ul/kh9fM/9zxOpKXdSIDTDG
         bLF0DfgNI1f2WTG3JKY4p6M4BXmHkUerNTRZQ/fr5sFocAbdJQMangtisOuJ6EDhMn5Q
         9ZBTHOyEwZrDs5pGYjeMA2GMcoBiF176TVdjVj8opaB6CM4GVw/dEEA/o2GFANRFR0Sf
         IwFvKIANgRDAuYVdCaALgCk8oYEleaJUTTQhekFWg+j61/lXussfHdSLVnPsC7PfS/Wt
         bJwPLwBeNNAtVzmymxoKb6oOEwFLb73ZzRMLEM73f98xPrUAWLy4JCtE7ij6Q1ReIrjA
         3nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725135344; x=1725740144;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjEEVYrxI6QjBkSeZM7AgitlYe2hgNyzH0COYIgadzQ=;
        b=sIj4CYp1QDeBX6YQRiK7XcM+QgWJpEk/V0A3d8ZQDednB1KP6CQxDVDo1ReII+518H
         26DlNDv45b6ODXqk+Yw62F+31uWey+AW4FFAELTcNqP21VhIb5tVe/7mjluR6DGmlqy8
         CA6NO7PZgkLGUa8ML9ovbMEBjJ6O/z0TsuaMMRMbqqsnK0XwULvDu+nqnTf+f5YohFEX
         SVtNsBb7bp6MQN6KBwbDSmqX0MK1DvtWKkDwidXb6ZxMs+MFMC8dYUkldRSRY0UYq2Pc
         +w4PMIURwtmunAoB2Pq0lLH9TyJByOWPYhuohbn9fuG++G7btun6vKK8JJg4X3vHgEiz
         uSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzMim9HjWex5gwLViqO7Ti2ZYXiws2Q0ZYdxVfC+52u/c9ebvzCbvbguLqxRM1cZL966fMaBmB2Ux+4in6rQk=@vger.kernel.org, AJvYcCXP4QHKBGgwG9kSLJUSOWfRxKinyGhswLEo8/D3IKgC8vjlWooOgfRNqPF0aRqFMexX+LItTh48V1Hvbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8efqyxvL7VpaPqDPWO5jls/2y1R/y23e7OoHmmswS/IheucYL
	PMlteuTmv4pnW4B963KQmUHSNScQG7N7nG+HkxOINqBh/qyf+t4=
X-Google-Smtp-Source: AGHT+IExefxJpc4auYpTPP57sN6+cSXpbYc1YRXKCl36LMeHJF14UdalLYG+4Ruzu9x0mOz4y+M1GA==
X-Received: by 2002:a17:907:6d0f:b0:a86:8ec7:11b2 with SMTP id a640c23a62f3a-a89d8ab4a9emr127715466b.59.1725135343283;
        Sat, 31 Aug 2024 13:15:43 -0700 (PDT)
Received: from p183 ([46.53.252.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb9c6sm358025666b.24.2024.08.31.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 13:15:43 -0700 (PDT)
Date: Sat, 31 Aug 2024 23:15:41 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH RESEND] block, rust: simplify validate_block_size() function
Message-ID: <005b6680-da19-495a-bc99-9ec3f66a5e74@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Using range and contains() method is just fancy shmancy way of writing
two comparisons. Using range doesn't prevent any bugs here because
typing "=" in range can be forgotten just as easily as in "<=" operator.

Also delete few comments of "increment i by 1" variety.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 rust/kernel/block/mq/gen_disk.rs |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -43,21 +43,16 @@ pub fn rotational(mut self, rotational: bool) -> Self {
         self
     }
 
-    /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
-    /// and that it is a power of two.
     fn validate_block_size(size: u32) -> Result<()> {
-        if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
-            Err(error::code::EINVAL)
-        } else {
+        if 512 <= size && size <= bindings::PAGE_SIZE as u32 && size.is_power_of_two() {
             Ok(())
+        } else {
+            Err(error::code::EINVAL)
         }
     }
 
     /// Set the logical block size of the device to be built.
     ///
-    /// This method will check that block size is a power of two and between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
-    ///
     /// This is the smallest unit the storage device can address. It is
     /// typically 4096 bytes.
     pub fn logical_block_size(mut self, block_size: u32) -> Result<Self> {
@@ -68,9 +63,6 @@ pub fn logical_block_size(mut self, block_size: u32) -> Result<Self> {
 
     /// Set the physical block size of the device to be built.
     ///
-    /// This method will check that block size is a power of two and between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
-    ///
     /// This is the smallest unit a physical storage device can write
     /// atomically. It is usually the same as the logical block size but may be
     /// bigger. One example is SATA drives with 4096 byte physical block size
