Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53D269B10
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887287; cv=none; b=ipBkPEIWxWCURCYE4TmmrXVRczbo2Y75cFAT/eJ1/EcXMis1tIHvbfQ9tsEhIKxua00m57ZJ+KETDFrSVYVhunf3K1JEmgojV17g9TDFMVDNGc5yklCRPveJ7KgpXhEslggEJYvWFdm9rriXC9hxHx+1krWONqiC8GBvbnns7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887287; c=relaxed/simple;
	bh=CUUtLbg/V9NQg+AuWoIWQTSD1MxC1DHpXmOuggSU0+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sK2qlyzP6K2ppaCN04ME5TWvyrC+Hf12VQFTdTqRQrqasW9LKVYMxxckiY1QArDOPBv7BJsUakiHdVGi1hYwzSjX6c+XtZ58M6kA+yhxFijy8xH0Cl0nWv3VR2AQXpMDIP5Gv6Vkd72PWrWQSwu7tGeYgnkRnVq3hiotV04BZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GRL89Bdb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GRL89Bdb"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB9193F869
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739887283;
	bh=9baZ8MtjuJOAuAOdwVfX6siiAQJttTW47fGC4JGW+8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GRL89BdbmoEnL2Ht8UxDy4Uq0w/FnipWjYHXCBpbZzeB1A33DcXPiM1odhmJqfXAv
	 szT/ArjHRG2D9pQi0I4Nw5KrnTDBo/q1tX6lVT8n8N9vJXuZInB/1uuabL19+D+O0x
	 3eOwHcKsoHuGhnvD1i5wL7ziUf9gOxRxY6QJdqzXD09UqlIhGJcrRPU7FhAYpiaoFY
	 phfNZE+BT7kKWIjA1qth1ByiSc3Ft5Fctm7bWWJc99N9WRWzq1NYwgDsV1HWM9J6aQ
	 ZhUDY1SM0kkuXfJLL271W9WNmhWOcV77o2C7YgcTECBAuIP9dkSlN4Ret+mj5IT8nl
	 H+q/rFnT2mKsg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso2236914f8f.2
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 06:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887281; x=1740492081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9baZ8MtjuJOAuAOdwVfX6siiAQJttTW47fGC4JGW+8U=;
        b=uIZHvSne+jYTmPaBYfQJvCTaZO9EF2aQEoG1JM8NS7n5S4m4EUejvkELXu5dhdAbaB
         OMKLBUzy1ScFSzdwZ2CM9+Be2veCMi5Cwcj5Xa1cdiLQJiDIAW9EsfKpb+YW93U6QU0D
         0nc9MVY+AFhY/L6+xGWGCRCm8GsgsujyxkpLXmhCRo26QqVZl90Qil3PNYjyZpaLpjim
         8bGarvhEOB0tBg1ENycmC93A15jeC6+GLZ+CWo2V11koiTp9OBYN8wYh/NKjEbb3KvpN
         K2N5hqwXEVGQtbjcKi0b2M0K8ZWW/MeOIzQmovB04j43JZbPaWX7X9O5tr330Fz8eHlw
         z5uw==
X-Forwarded-Encrypted: i=1; AJvYcCWUS1qpH8E5b9YPr1tRCJ+UiQ8t0rHceTY4i6Cqz3J4s8gcy3Gsq6TMPGH3A6CVXl9MOtGdgwf1qCJ0tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxuJ3rMV1VpL0F89CqnTZgJ9vetPwGB62zUWZpizr+QpKys9E
	3Gi8uOxCXAU3CGXH+TGSm5YtQ/xFHD7o5EI+vYARP35+wueIk4BdjQo2Fb+LmeFzJxovrWlqLFO
	M6gLLyFq8BEr/XkTvHGgHaKBDqbMgZfFO4PAVFRk/cuV1MVerQXh/vDBGpcsO3USqG2RCCzctlO
	fD
X-Gm-Gg: ASbGncuyzHnLmJ2MxefxpGjYH7H694xivxetewCt1pQIEPhCPQIbVX3sP93ykOHnYwf
	ZB7O4XFCr92fCc/PDOFZvODiMIluL00DucpzWWqXyTl/n6WfVKX6OVJeYawlXSczhianoxYyiQ5
	/D3+FO6Ay1JllZQF+j/4fgYH8SIoJVVyRJZcTkI5V2u/WugsTY2MwVJ2G35KAu2pgOdXFrMW0Qy
	u8GPU5DomRwuvvdpuO6ByZp6Z/6jyN0w0lYGc3x5+OBAELaRVqirwjQJBEk4Ma6Fijej8bS1Pn3
	JtMwJgBFfKR/rFnTfWPrOKEuZ2/kKwSjft8AlZg1yqBzFdO6kow=
X-Received: by 2002:a5d:5f82:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-38f33f14a34mr9766460f8f.4.1739887279392;
        Tue, 18 Feb 2025 06:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3bFoFj7AvC39E0Kp9bB9u3iWm4LdGhfLWfOqb0TEnl13m+51JdBvSgkS7pO5yYT484fKs6g==
X-Received: by 2002:a5d:5f82:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-38f33f14a34mr9766394f8f.4.1739887278805;
        Tue, 18 Feb 2025 06:01:18 -0800 (PST)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm15105057f8f.29.2025.02.18.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:01:18 -0800 (PST)
Message-ID: <4cac90c2-e414-4ebb-ae62-2a4589d9dc6e@canonical.com>
Date: Tue, 18 Feb 2025 15:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/1 RESEND] block: fix conversion of GPT partition name to
 7-bit
To: Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc: daniel.bungert@canonical.com, Olivier Gayot <olivier.gayot@canonical.com>
References: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The utf16_le_to_7bit function claims to, naively, convert a UTF-16
string to a 7-bit ASCII string. By naively, we mean that it:
 * drops the first byte of every character in the original UTF-16 string
 * checks if all characters are printable, and otherwise replaces them
   by exclamation mark "!".

This means that theoretically, all characters outside the 7-bit ASCII
range should be replaced by another character. Examples:

 * lower-case alpha (ɒ) 0x0252 becomes 0x52 (R)
 * ligature OE (œ) 0x0153 becomes 0x53 (S)
 * hangul letter pieup (ㅂ) 0x3142 becomes 0x42 (B)
 * upper-case gamma (Ɣ) 0x0194 becomes 0x94 (not printable) so gets
   replaced by "!"

The result of this conversion for the GPT partition name is passed to
user-space as PARTNAME via udev, which is confusing and feels questionable.

However, there is a flaw in the conversion function itself. By dropping
one byte of each character and using isprint() to check if the remaining
byte corresponds to a printable character, we do not actually guarantee
that the resulting character is 7-bit ASCII.

This happens because we pass 8-bit characters to isprint(), which
in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.

This results in many values which should be replaced by "!" to be kept
as-is, despite not being valid 7-bit ASCII. Examples:

 * e with acute accent (é) 0x00E9 becomes 0xE9 - kept as-is because
   isprint(0xE9) returns 1.
 * euro sign (€) 0x20AC becomes 0xAC - kept as-is because isprint(0xAC)
   returns 1.

Fixed by using a mask of 7 bits instead of 8 bits before calling
isprint.

Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
---
 V1 -> V2: No change - resubmitted with subsystem maintainers in CC

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';


