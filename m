Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9846FC3
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409056; cv=none; b=VOq2sjYKODXkoGqtvdtQ+TRzcbqK3GmE+8cKuSio7vAyI9u/kXahrnxmuy22XcMxu3gTfsrTx4ba6j0vBPBtjRADTZPOZJbzsdzNFyvRQuc3CxRmRtO8dN76g3XuSyFrPBFqH2nu+zuWzjU4GZgZJZ81sT9l6SjTP5aJ31fj5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409056; c=relaxed/simple;
	bh=OPsH+J0IMjvbXM5Z80c3rcRa1r3Wk7HlHjbd9Nuzr9A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n4CpZ4FjcoaTv4vboQiu6sAw1YyBm/pqY1BVDM8h7M4XWJ1ZKaG+lAmVZrPYfFg71ZvXNSBc9tp501ZLWfCqDn+svMQvLJ2KOtZLzjtDm4KBbsDSgj/s8Nq04AprV2il5PrO59jluBbvm553pMHZqGFSnIfOpf4VLymbQkItZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=beZS+NuJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="beZS+NuJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e41e17645dso3328746d6.2
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2025 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739409054; x=1740013854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBTW067S0LsI0ydyCH/iAFJRADoFFD4WiemBeNRQ8bE=;
        b=beZS+NuJd8CyLRSvdVqxGrPqbUOAu19htvQlZT9n14El+WvTdJsva4kePB5JEk4FN9
         LMYoIyG+fY37QAMcrxpnogsjJRm8lM37eDq6xdIYMNg3L4ZQXLwbFPFffpJ+QxwqA1EN
         szUjDDnxX3byFVZmwQ3lbvpA+zCjg/3qIY3t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409054; x=1740013854;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBTW067S0LsI0ydyCH/iAFJRADoFFD4WiemBeNRQ8bE=;
        b=voQIHBVJlFIfWyvwd84YnPcfGL76BvgtZkRpIdmjNoL7c3a+8MTVJ/Y4W3r9SMzetB
         Q9Bf3L6XC9SGGbb6mVGuq1waE/8onqGTxyeNgyWG9FkBLlBIXKHnZsY4/b0aT9Q68LwP
         yIbC1w34MSDF5NSjR2ZUx6sRdJrqaO1Y2LcOE6EFDgKEQPHfNOmVYGWWdNCxplX6lDXm
         oniTBoMKfH3hOyTc6+akpFDdhTlRawqsM5sRpd0oKw3eL+oxfwQ/dEd3RcelCnpXutA1
         lrbiUOv1TJmk8sieDZflXAPiEDgPZWzqnMK4lH4vnOAOmXikroShDKoXUVR3gDLXtyYN
         gHSA==
X-Gm-Message-State: AOJu0YyXRw+EPSks4CmAEEG1NfG2DaTIdBNv1EnRd2Vgziq+6oI3NPld
	3g/ExjNCwksfZ4yqZjJcw6YrOt9H8GfzVZ/rq0j/h8V3T/XXdfwdB0wQigI6kBD7q+aZ9yWElzg
	J0iWQ348nVEa7dpbC0E2v66JpoJvjmbNBJEX2
X-Gm-Gg: ASbGncvNukjCBpwAKbLP735bTxBTblSntesdXlwrZRDm4+SoLcW6CSq0PRUprfiZRV7
	FmoV8WW4hJ3Ka+nkX29OzimMFJHXD/q+PE8ucR2VhygBA1ooc4YZohqNjwuAciON+t9WWYeb1QD
	wdpLlUpwVfi2Wif9g5bcBqwWSlMQ==
X-Google-Smtp-Source: AGHT+IGtdfOKy9DB+E7aUcl90+95bCBXSRaedHW7QE863sL1BrkbRcjRAOINQVNnxOZKV9N/kq4s1lABwbURnunNX4g=
X-Received: by 2002:a05:6214:20aa:b0:6d8:8a7b:66a4 with SMTP id
 6a1803df08f44-6e46ed82304mr99705796d6.14.1739409053957; Wed, 12 Feb 2025
 17:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 12 Feb 2025 17:10:42 -0800
X-Gm-Features: AWEUYZnmD9KZ3N5_EgKqOdofTILW6tg5UmqVPWktggKrMjIwqy0TVxyaTM7MKPs
Message-ID: <CAE5=w7odv-cL6PJ=ie0bE5UYpfzEdqpB4vEo_FQm0fUTLDgXYQ@mail.gmail.com>
Subject: Question about backporting w/ missing bitenum members
To: Jens Axboe <axboe@kernel.dk>, ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Heya, I'm backporting 752863bddaca ("block: propagate partition
scanning errors to the BLKRRPART ioctl") to LTS and noticed it
conflicts in the blkdev.h header, where in upstream we had already
introduced another blk_mode_t for bit 5, and this new STRICT_SCAN uses
bit 6...

In this scenario, would we prefer keep the bit used consistent (so
have a gap with an unused bit 5 - what I would typically go with), or
renumber to avoid the gap?

In question:

 /* open for "writes" only for ioctls (specialy hack for floppy.c) */
 #define BLK_OPEN_WRITE_IOCTL   ((__force blk_mode_t)(1 << 4))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN   ((__force blk_mode_t)(1 << 6))
