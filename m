Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630441A92;
	Sat, 31 Aug 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725130339; cv=none; b=Yy5xlaqLeyD43YxdaiXKGgDxl62rlUpAXj7HW5/2vXjdE15ujH4n+SYMUC0Si61KjVhrHBkWaKeg3uhRey+EAqAs7bBmy8ngWNz8od4skVl7gXolO5aDJaqIhOHHSX538nPPuCtlnnHllAVqsuPFWRNSXHnRsVxpzll/pHEd6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725130339; c=relaxed/simple;
	bh=oZcXvUXXckXFe3Fulh/2isJwgVUVzsEf2bKp94fUVrQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Oynz9c6Wn8HdW0D/P4SzM9rfpPAnCyv+dDUyODchyIP+Jc4ROSINdnXVYDPyGl310q/65yV8kHXYsnXRop3jYIJ7d+wXPkisegXjVmh4MX6+uNGWkpj8Nb2IcWyZ+jtFE+oH8RsVzkAVcYq96kqJQsRp8wL1gdAv0YJyurCdrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjFDsbZy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjFDsbZy"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso2969284a12.3;
        Sat, 31 Aug 2024 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725130336; x=1725735136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oY9lQXO2YJxWYzwah9ZcohmjD5W5SmMFOyh2JPrD/aI=;
        b=FjFDsbZy8ihTWyEZrycprNiFzQs9Z13/JYTS8P5zaEbJ1N7tl9hrDsuSFNaHdLWqnn
         GA7ECij4mBt4/Wb6wDCLldERthqmn2wdde5AEEMo/b7IFIJzxF6T///cv3qcm0QwKIBf
         mHc+aEPFKGZTFdRLZF0pnTBI3s/zaMYcXRsGACKUZpEaqtIcoLYqY9PqdSbQf2VQQupm
         1Z6x1sM4NDXpvKwKM4IMcGiJMZFhqB14kbwff8XAN4r3NjPMeGpT7zu9+LRWiWwz4AfO
         OOHweV6OW6aDruuwLviRUWkO112nkXovz7gDbACCgfKrhhSg0Y7uMimySIAbQzdzotaP
         C4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725130336; x=1725735136;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oY9lQXO2YJxWYzwah9ZcohmjD5W5SmMFOyh2JPrD/aI=;
        b=rH6MyZmROS/WnDvw+2cmSZMUQ2RySVDIU1jXpMhTGtkCdTzJCQXKXP05ZSHXoOvXpx
         kiGhD4ErJZv249DenUtPESDtzGZI4iQjPS5C/ae8LfwtYBHh78iQr/dS9BZnv4+cnLCf
         MsyaWsdn0G/8MA0B0vwz630Yrt0GeXYUBaQ8HTvwixFwL9n6r14LMtytifQyTzm788d1
         TKm2HdqiQTvAWJhfwMYVVeigsEOv5+G4hm74Tfg7LYPPQS7EiuYO855FpA+3TdySMgHY
         Bv4l461747pwCuBgVJg1ivCKg+UZiNRIlzEGSoJOLod+6Xn3j2Du+Xa12U3j3sFu/Sxk
         3N3g==
X-Forwarded-Encrypted: i=1; AJvYcCUlA6FIulpZClE9AhyK6CeqjaZ0I4uUz84aUqlZOUILj1DxORmAKpFh8SAAVKNcsjkQxOa53WlJYqAVAQ19qS8=@vger.kernel.org, AJvYcCV9YshS+0Tr+ZU1Edfd3zr0qsm7UBBgqi5JtUDtAgnfQJZy2aoMLERgKpLsV+9eFNkksoP/h3uUCvWXaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Q8WHCtPlMwQESKZyoElehX3eKAM66JqmnxHM26UcTpPxiPIT
	vf0D/LN+OVOAfj/4YyUmjgr7eVwu4PBesNg8ywP85zhguZ5t6YQvs4yKOJwUgn95lFW/4mn6iwL
	p1jMaCUQtyGPmRI/1PeczcH+row==
X-Google-Smtp-Source: AGHT+IGpRClRk4den7Saed+QN9LkG/nihHd6RHD1rD6FH9ArtieggtwhNJHFa+yWTkq/LH2hMyaRFit3baDrj5xDSjE=
X-Received: by 2002:a05:6402:234f:b0:5a1:1b3f:fbf5 with SMTP id
 4fb4d7f45d1cf-5c21ed3e07cmr7855333a12.12.1725130335600; Sat, 31 Aug 2024
 11:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sat, 31 Aug 2024 21:52:04 +0300
Message-ID: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
Subject: [PATCH] block, rust: simplify validate_block_size() function
To: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using range and contains() method is just fancy shmancy way of writing
two comparisons which IMO is less readable.

Using range doesn't prevent any bugs because "=" in range can forgotten
just as easily in "<=" operator.

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

-    /// Validate block size by verifying that it is between 512 and
`PAGE_SIZE`,
-    /// and that it is a power of two.
     fn validate_block_size(size: u32) -> Result<()> {
-        if !(512..=bindings::PAGE_SIZE as u32).contains(&size) ||
!size.is_power_of_two() {
-            Err(error::code::EINVAL)
-        } else {
+        if 512 <= size && size <= bindings::PAGE_SIZE as u32 &&
size.is_power_of_two() {
             Ok(())
+        } else {
+            Err(error::code::EINVAL)
         }
     }

     /// Set the logical block size of the device to be built.
     ///
-    /// This method will check that block size is a power of two and
between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
-    ///
     /// This is the smallest unit the storage device can address. It is
     /// typically 4096 bytes.
     pub fn logical_block_size(mut self, block_size: u32) -> Result<Self> {
@@ -68,9 +63,6 @@ pub fn logical_block_size(mut self, block_size: u32)
-> Result<Self> {

     /// Set the physical block size of the device to be built.
     ///
-    /// This method will check that block size is a power of two and
between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
-    ///
     /// This is the smallest unit a physical storage device can write
     /// atomically. It is usually the same as the logical block size but may be
     /// bigger. One example is SATA drives with 4096 byte physical block size
