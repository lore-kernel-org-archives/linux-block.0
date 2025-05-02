Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD0258CFD
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199534; cv=none; b=Dm8Ja870sZMrWw5NoHQO2sXuJQb84JZ0Swbk5qhVrRcEfMjhfPGCGL3YA+9NY0yE0I2sK7NpK06eM6jmCBDwkflpNyOnlVdxL2AqrgfTUwr4E/GrHwkQkOSKgO6O7PzX8lBigrZtdvtrraaAVQTGCTM/pRdnD3Zh10AUVhMRpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199534; c=relaxed/simple;
	bh=pqY0MN29Mdh1goI8G84Wi6zCZ/NZpChHhO6QOqDWs7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TRe5wZX9R/U13iDyrvaXuEYZ2cjbnooMSwMxX1gXt2Xjn0WwJxogdJ/KoYC3sKSuJGuU9oDF5EmkF8TaU+VpXCV+AQ16JzCqN3eB0D97MjgguWsx5sxROpjceWkhA2/T/ARx/ghSOwHbJqa+oNChYMHawsAJmrb9BguFBP8B8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oddsGi/u; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oddsGi/u"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8647e143f28so190993839f.1
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746199531; x=1746804331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktvJ6GL2VHKlqfUp9zp0jfzB7CN4Pf2PARMJI+Ww564=;
        b=oddsGi/uNRivO80i3cDIxO/I/o4XDo0g8EWMFsGyEFTtxodwu+EsqUQzdXxpbRkyhw
         TafLoqrpjl+rpQ7wBCqao1kom5HKBNBb+eDxYyNChVjdHzNB5TYnVRmyRiuNnIelOD/T
         Oid0lWIMWePQkVWLxemuweLqOSrTiURRq4j/ea0Gko/NSQddPjKwHArX/hLeUSMMP8sj
         T5+1yQRHi2rIu2XfqzDcHOeqGdGLwtNjN3kWCx7mkYNPOIGSPyX5nIoP4vjMrPorzvIQ
         Y0s+Wbc2ZBNwCzuEavsE0yo19a58KByFHGmAL5+1bZ8YGC1ukmRys0rcs47B0hQJDwiJ
         AMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199531; x=1746804331;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktvJ6GL2VHKlqfUp9zp0jfzB7CN4Pf2PARMJI+Ww564=;
        b=eWE4Usc7fTQxABzuS2ESvVS3OzzFavrluJmZpJYceCjjrv2JGgMXlZpY7ItNUOo2uH
         MWTgCmg0mFqkW0CHVvmokibWtdhqU9eB7gYIef2Ns7uQmnvIIDdHvYy2iOxH+iIur/sC
         UTrHa/hyoB681zgYhZHPk8KAjBHfOc94Ejc3zL8FNrA5w1hex8Pi9weOzIuFGcVJFvID
         A2ez4aBDhkuS8NvbIsnI2qnAxZLui0i0wWKVlvZTAtKIUmhmI4bIVdg2p3lwl9U+e+46
         G86nowzY2MQ8cHkEB1wqYPO28KpVS9w9d7hmkgDLl1L2sxSG7E0aSWaTTX6AetMjOeut
         DrSw==
X-Forwarded-Encrypted: i=1; AJvYcCX4qdX7uWtUAHWorucuwmWKYyu7YlUVzsTn4gl9K798hWiIVTBHK4y15W0EuYkVfVbVUPTuWy+hKSaacQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBus5h4CpqfJ+IwpobULbc9pH+5+BIzZBXVkqKd/HbRFpTsMYq
	rt2q8T36e3JGziPzBfJSJF6KDPuO/XhAAB2skbAuiHcCif6LitR5ptq9woTMRB8=
X-Gm-Gg: ASbGncsEi6KzmuKxJq9q/3QY0V54HVevcLe/1YMlPMNQImwSC+P2alqiABXuh/rrkAt
	n7IULVkv8ZWC7WLPifdr6+/2z82G0z+pheaVwWpE8aghFCGiAVy2OzPlKOSuufCYbScdgNX9iz5
	Sxla1h/5ZbAhsBNatQaMNbJsYERoXu7tjJqG1Gqh2xtziJHj0h6nB1o3JOoxnWI8Ui+Y5+0tDzM
	z5JUXRbGlbuClbv/x4k6dNaOXfYd0lgYl1ID3cwEcbZr1p/VX98+T/XzP2JRncIre1MAHSbMF28
	7hafjedfBIFlgAuXdDaqFuNzorCO5r1njeQV3TKPzw==
X-Google-Smtp-Source: AGHT+IEl5txDpAkr/IpzX570Ho9QLPBFGnfb5pOFaOhpmsfAkNtNXEi7SaGfECANczel4I1mfYIn/g==
X-Received: by 2002:a05:6e02:1fcb:b0:3d4:70ab:f96f with SMTP id e9e14a558f8ab-3d97c199938mr40956615ab.8.1746199531061;
        Fri, 02 May 2025 08:25:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8e1f7sm429300173.121.2025.05.02.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:25:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250430225234.2676781-1-csander@purestorage.com>
References: <20250430225234.2676781-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/9] ublk: simplify NEED_GET_DATA handling and
 request lookup
Message-Id: <174619953036.748556.5897249938124902151.b4-ty@kernel.dk>
Date: Fri, 02 May 2025 09:25:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 30 Apr 2025 16:52:25 -0600, Caleb Sander Mateos wrote:
> Remove accesses to ublk_io's cmd field after the I/O request is posted to the
> ublk server. This allows the cmd field to be overlapped with a pointer to the
> struct request, avoiding several blk_mq_tag_to_rq() lookups.
> 
> Fix a couple of typos noticed along the way.
> 
> Caleb Sander Mateos (8):
>   ublk: fix "immepdately" typo in comment
>   ublk: remove misleading "ubq" in "ubq_complete_io_cmd()"
>   ublk: take const ubq pointer in ublk_get_iod()
>   ublk: don't log uring_cmd cmd_op in ublk_dispatch_req()
>   ublk: factor out ublk_start_io() helper
>   ublk: don't call ublk_dispatch_req() for NEED_GET_DATA
>   ublk: check UBLK_IO_FLAG_OWNED_BY_SRV in ublk_abort_queue()
>   ublk: store request pointer in ublk_io
> 
> [...]

Applied, thanks!

[1/9] ublk: factor out ublk_commit_and_fetch
      commit: 0cb39afd2a4d438b16d743952eb68c683c663a1e
[2/9] ublk: fix "immepdately" typo in comment
      commit: 80c0789a7ddc89adb726e407ca22d9689608b710
[3/9] ublk: remove misleading "ubq" in "ubq_complete_io_cmd()"
      commit: 5a43d93588dca88af0333ce18dedcfb0276ec4fe
[4/9] ublk: take const ubq pointer in ublk_get_iod()
      commit: 2a86eec6396ff6d40e46d5cc11f99f1e7bbec78e
[5/9] ublk: don't log uring_cmd cmd_op in ublk_dispatch_req()
      commit: 551270690dd6c751a6d62f272cf068bfef9a1729
[6/9] ublk: factor out ublk_start_io() helper
      commit: 2fcb88bdf2e62a6aae211c8603341fd2e7b16a69
[7/9] ublk: don't call ublk_dispatch_req() for NEED_GET_DATA
      commit: 9810362a57cb633d808cdfd51e8cae21243f0660
[8/9] ublk: check UBLK_IO_FLAG_OWNED_BY_SRV in ublk_abort_queue()
      commit: 8ed95b54701a8e946b86ffdeeac8603316e0a59d
[9/9] ublk: store request pointer in ublk_io
      commit: 64d1dc522b349a257256f636feb335441cca2571

Best regards,
-- 
Jens Axboe



