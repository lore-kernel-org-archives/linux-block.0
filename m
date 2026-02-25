Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37E33A6E4
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033837; cv=none; b=vBjfhcTNmyN7izRCwrhX4uCXxHxl5+upgzQrHauZ9nU3KucGiJd4In3YQBZ7PXAUy5OHayGLr/leMKIZmJcVugolYFKFOyU8TuiUgK1YGuk3iz673BEevlMO/d3pxG3QbSGVS8oFhcZv8qFQ6Z+OZwk4TDSZr+JkBQnqfRmocQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033837; c=relaxed/simple;
	bh=FlZeJcBOaz2U/fTkoS6aunoGzRhgYW7IlVw1E8w6kr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=clZNvVJsACwQSdNezGVDM5cDnHCs3fLeReVLlmQkYow32QDOg6r6CDGpRtLtf/71/ZDdVQKNnlN252RCZX2LnHopCGzOut985gQbTZZ14Idv2aAjKmNJmT6lWYIuxxsD+FKsPK4P46qAFYmQH5CU9Kjy894MO8A7Ev+kgXftld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Gs12kqH0; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gs12kqH0"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463ba60966aso2349883b6e.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772033835; x=1772638635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Cd81aM/njePzspSAxnwsOPdwm2lPskwkQ0BrWRB6SE=;
        b=Gs12kqH0EClxinmhS/2xVDcXT4IwHN/x63Pzke1CHY3OCyytSl9qXly4Gioafod+lY
         uJ/kcShSmwp92sfd0VDYIV+WLhv8fjJRTyQY3XKVHJWhjrdHQjDLYw/ynFCYFv9dTSNE
         vzS7jRCBFn8qaN95RPgpxhPkVYFQjK72j9hIS2eJQVjOWX3nZqDoZjsGvhI9cUuo88+9
         Uh/DAp8OehXVJgLQeKscW11r/5xQoZPnM2XVrpGJySAEvVZ5VOo/4WTVKO9lae0vhWpe
         fsiHdCkeD/VmFS/1E/eKJoG6sH7flrXehBucsXauEm+YHcu7DLu+rh55+HBEi36syCjM
         8wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033835; x=1772638635;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Cd81aM/njePzspSAxnwsOPdwm2lPskwkQ0BrWRB6SE=;
        b=QnR2WkpF5Qnmoi6VRSvFRWJa/G08xmGXureZVEHI6HGxLmDdqD2fB7S9t6jrrXwA0I
         WQqCPVE/Ufx8EBRwqDCUEWp08tuT1IkxFaRwvcqacIX73c8KGt/1BZN2r4WaAw+49EQo
         hg+/cQNtYeO2fyFUntsJXJjY2IvNBcwRiJOx50vBVueanV33nsfd/joKouyZNGXuxL4h
         eN71TXyjhg33YnhHADMre8GoMu502Jqeq5sAtGSZUmgckxdCgPuCMNuom8Id2zK7CirG
         RgUcflX7WUy4l7E8XCgJaDAHnuNUzpt8Mr3GbGly0BSu0e50EsnA70l0NRRDg3shPW0f
         EgqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyhbz/l8MRvynrTo89csR4Xx7CVWwF4UVNIywVX7EzA8EK9ZMJsjL/xhGeTJ7c/SPaQ4HNNzzTGCmQlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywZc5j951LYJYcWBE3QNnBwqyx4PwhbtBosE2p0bk3GBE87Ev8
	Sek7OGUOhddu161G6dm592ulzSvRcmev+Q2frmB+VMoSUzRFRCwGvRA/6gxWgCpoSRY=
X-Gm-Gg: ATEYQzwc+DaL/gUWckS6Q/Bq6/AlqN6dLTCcCkyHC6NQhwijTAilRTBv/5Qls9MHhpO
	2jgxjbNKuL1QFGqzMcuJZp11CIgGJfg4McOEsWyP0md78/UMRRfjXOVEeUsnEVxJGWgibs9wHUu
	MaNGW+tIRlMUKojmjCqbkkS1mcCUlnXhqy75HTHDqU9hou5GdbhfoS0atLniRXts0tKFYb7uywt
	oOk+UYSV8kOLMp75jZ9S0RqCSFl3qbWgqBMHzJRqlMCWZ292L4i4TsCheYtItybTuh7QEj/vD4g
	DKa2ICvQ/Rn8O2Gw+KROwNVotiNCXDqyD9RawRViq7iLqw4jXp1E3Y4PKWB/ezlnah2jlameBxf
	cOhMwncGTBQhZDi/weO62gOzC3qF0QtbGrUk8GkpL8UY6zMznnyFgo8roDs2HrYQo13OwSY4izV
	yY8kFuvP5YZIhXteT7LW4dBRbdfL0038Y5GxhVYjFQWveXam43BkUeMQs6OzlBzxeS1VwgzuWdI
	zwm
X-Received: by 2002:a05:6808:13cc:b0:450:471:b9ba with SMTP id 5614622812f47-4649ee9eb27mr347296b6e.14.1772033834674;
        Wed, 25 Feb 2026 07:37:14 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfed28esm12886128fac.9.2026.02.25.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:37:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224155724.3142007-1-csander@purestorage.com>
References: <20260224155724.3142007-1-csander@purestorage.com>
Subject: Re: [PATCH 7.1] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
Message-Id: <177203383367.841680.9573404766527230977.b4-ty@kernel.dk>
Date: Wed, 25 Feb 2026 08:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 24 Feb 2026 08:57:22 -0700, Caleb Sander Mateos wrote:
> The ublk driver doesn't access request integrity buffers directly, it
> only copies them to/from the ublk server in ublk_copy_user_integrity().
> ublk_copy_user_integrity() uses bio_for_each_integrity_vec() to walk all
> the integrity segments. ublk devices are therefore capable of handling
> requests with integrity intervals split across segments. Set
> BLK_SPLIT_INTERVAL_CAPABLE in the struct blk_integrity flags for ublk
> devices to opt out of the integrity-interval dma_alignment limit.
> 
> [...]

Applied, thanks!

[1/1] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
      commit: c1dfbd7e71b0a75374a4e65c9d4c6eb66a31e6fc

Best regards,
-- 
Jens Axboe



