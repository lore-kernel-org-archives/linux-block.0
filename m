Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B185626
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170309; cv=none; b=j6n9WI1qoyVAKkmrHJshxzE6HTq4aGxTtEPaBPjjjDwasSft/0fzcx/z/MPaNGnsYuNfDXQ/J6XVFLEabklughxVd15AKV2HY1TyG5hl0a4P3yHy8iIMVu42/xMp2dvWdeg1EMk29GSV/h9evg7+FCG9xRysuBzUOMY8E2ZqzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170309; c=relaxed/simple;
	bh=elVYhPQRFlWLhglVSLuU/FJpx391AypSZPzM871kkX4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nNukZVPO0/tNu9mItwwvJuvfO9IEBLjUxqM1HLxyxWJEFGx443GkzAiFmBslnCEMwYIL7aO9vYJYvOL67mqwE2YPeaeKPXOn3STdVdVCWuvad35O6iusFISMiHyvZtBh76Is9r3zhBg85Oa5GePeYZFcSZuLkNcIUTAxc3SupPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0PZatzWo; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0PZatzWo"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso38438039f.1
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743170305; x=1743775105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+lOshOSDK+kZjT8vUKLyUmkyIDptkaF13TWUrhIE+w=;
        b=0PZatzWoin/MW115Jy4FkGGytiIFCZStI60tfgQ51WI1VCpvUgwGLQgfeEuZW5Icbf
         uPARqvkgGRiGAffByMxxVRN/LD6mcrZQ8pyUNMn5YCGZSX0Mrk5ojUnnlQBC6oVg9/Qv
         MemNoFLdZ/IhiL06wbO5gpPG0gYm2EZc1sFLY0fzy0Q/wCI0c5+DkrVe9O3IX12sp/l7
         ogqjI+BWgu/NaMFdm2B8VWv3SHaG6r8Ger3WELTHYOHiXGNJVMQjKNgjieLYfztaNtCv
         G3oVPUzbwdPfUDYYnyJDdamPfZCZs065RA1jnDevUmlIyM2g9G7AF3PZ/sdZ0m/ZuaRJ
         2pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743170305; x=1743775105;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+lOshOSDK+kZjT8vUKLyUmkyIDptkaF13TWUrhIE+w=;
        b=AOHOo2OqzUinb+kD0ts7cG1M74sTqOkVHLAck11YpB6iqBvRCnqMigntYu4BV8+vly
         Z4MG/vTn+cMDoToYUsgSsBYXzdQGjSm+FAOdPUtnc9bc4skDG7AqbwFwQ5rn3KB4gctI
         1n14PHMa0lPjBvhI+sAejNAVhZNRGkV0lrkTtak/iFsgT26P9DC1ZiGyq+tJMcBVKDW8
         6KGz24/ECAtMF3qTzzvIDfIoY//CpzZj5i8DFBHp8m2hdIjleiBP9ftBva768ocAPuSt
         uoGodW+PpuDfoKIbiFpFdYy+ljnQjI4jGcGN4IiUhYvVgvDiYgB0LfQOwEvgQ2gA1VhK
         f56w==
X-Gm-Message-State: AOJu0Yx42G9MShBCysfEkUHZmMluo9NfUvrmLlBZLMkVxqdDkN7WaEzo
	qjCwj0uBrb7JXB1P+Ckkl+pSTCywScNp5pPIjdi51/kysdVfN1SGNk0ZYWh22nUtmxcTo7OXBkO
	k
X-Gm-Gg: ASbGncuBGWpiT0LEww81QxKRvSfwr4MRzRPXeYpoLbfXuhA5Csy1oMyPEnG9hOxDSxr
	udRK5grRB9mFciyDfZUpilm2GLhRns36P2gJTnuF6ymbFq+iY0z868CA6OTGz9rOIxOCsj6M4ti
	CzynqHyYSqRrLmpJ3RK9ZZXzOTpmzWIo9P936fiNJuGcO5Tq8iDAp3TVdDeQ4nO12le94CFCxXB
	I2DIvpQ50/N0xeqZY0f1lyL+8JZXtjtdn504gbdlPpdTEDi8YKKfUcygYOhwha9my22+8EbUEnE
	bUwWTM9/lgpFJgZZ9EvZRJQYI3v6LHer0hw=
X-Google-Smtp-Source: AGHT+IH1xmSGTtRDWs1MMEvVtwYtLcsUnpoljMUT0KrYvHuWXBngJDfFJCNqi9wFPHCziJsYZABtbQ==
X-Received: by 2002:a05:6602:7286:b0:85b:3e32:9afb with SMTP id ca18e2360f4ac-85e82197c43mr1064731639f.14.1743170305295;
        Fri, 28 Mar 2025 06:58:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464871962sm451778173.86.2025.03.28.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:58:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 00/11] ublk: cleanup & improvement & zc follow-up
Message-Id: <174317030446.1447077.6348308752164590305.b4-ty@kernel.dk>
Date: Fri, 28 Mar 2025 07:58:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 27 Mar 2025 17:51:09 +0800, Ming Lei wrote:
> The 1st two fixes ublk_abort_requests(), and adds comment on handling
> ubq->canceling.
> 
> The 3rd ~ 5th patches are cleanup.
> 
> The 6th and 7th are zc-followup.
> 
> [...]

Applied, thanks!

[01/11] ublk: make sure ubq->canceling is set when queue is frozen
        commit: 9c397ab202da574da65be6f4901d6260ad28d420
[02/11] ublk: comment on ubq->canceling handling in ublk_queue_rq()
        commit: 2563451efc04e6e32b089696d221498277b5addb
[03/11] ublk: remove two unused fields from 'struct ublk_queue'
        commit: b4ce4eae5c0e3afcdf4a1fb8c85e5c171a2ea5db
[04/11] ublk: add helper of ublk_need_map_io()
        commit: 8a799a1616dd34724d9283ca0c4b96003da53d6a
[05/11] ublk: call io_uring_cmd_to_pdu to get uring_cmd pdu
        commit: 639cf001d7cca2bdaccff3f545d80394b6b36a53
[06/11] ublk: add segment parameter
        commit: e14e391fc9cc38a54f7528077930eae4f573b58e
[07/11] ublk: document zero copy feature
        commit: 9f7862ebfb05db6ce88f6eeb0e6144cda284cdc2
[08/11] ublk: implement ->queue_rqs()
        commit: d7aad08075f13bd9eb9cc73df831278f6c843aa4
[09/11] ublk: rename ublk_rq_task_work_cb as ublk_cmd_tw_cb
        commit: 48c74741b43f77e7fef74f2ad2bb714bdf1675e1
[10/11] selftests: ublk: add more tests for covering MQ
        commit: 7e1121b53e27978c5e33f241e87f4ffee45febd9
[11/11] selftests: ublk: add test for checking zero copy related parameter
        commit: 888ba37f212022926462d7d0b993ee5354a30907

Best regards,
-- 
Jens Axboe



