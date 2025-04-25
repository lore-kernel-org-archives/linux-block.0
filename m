Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F72AF12
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745546003; cv=none; b=IVkfR+K8ViUQ5UeI/WtWdM2eiXkLoqbjyzv4WcMOrdY+e2O2KOHZYbEtRzMnJHAOp7ngsg+gAaVGdK2KBLiDQfgPLFvOgS1mJIYv+OGEOmoJbcVRwvoAudD4OOMUpBVmXDMEqnmBw8XsRk4H9GGoFteD+vrQ3T2fd1E8hY0J4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745546003; c=relaxed/simple;
	bh=sEZHPEOKnQqkBG6HLD3bSmQH0L8QvOfo05eh9b02nPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bbet+Ym3Rn0cCHVV3u/nojOXeCi6qSu36srLrFCgXBho2tg9KeWgTA4If/B0mMNk8Kujw3IwTGB4TbmoIRcnURCAzCGOl4pcw9oH3yM3kRS1PwmiUhMmqpYUiwLOyRcFC2ArpGwdg4vqCiGhOO0Pytpkyz5aHvGHqegMsU8CQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TgpWVLUT; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TgpWVLUT"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d5eb0ec2bdso5793465ab.2
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745545999; x=1746150799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djp44Xpjlu2TOxKDRf3V4nFzo+R1lM7WYShYmrQcU94=;
        b=TgpWVLUTeUIQsGR0SZrVud6w1eIOJEd2mECETydL7ArgStCUy0u/5G8WnQITZ8ykVl
         vkqwGcFZd2NP8KqSgCpjM9UfVMRslgiJxFwOV0ISjVyXzO6gvGJuefCX0nX8krJPPLf1
         7D1IFZux12bdGV3ajIXgrXXvp9L9RbkzSzXvrBlc/vZXdWJ++m0pb1lJa3Imf8TwEEts
         5DYfmLTlDe8jfki6Jp0OD/SYHZW2DwhZUT4kqE/8O0lAaj1H108K7u1b2eyHKcHcJ/aF
         zl7G7FFLeZNwMxQjL9IDZtxKviyVjrtpoCDvSQaWUj96t/Vf5cF/hyz5aNOSrH5l7ELX
         6oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545999; x=1746150799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djp44Xpjlu2TOxKDRf3V4nFzo+R1lM7WYShYmrQcU94=;
        b=SR/jQNH5r4VW0Ne1XcVPngExBV2N8BLxaNkhHmQ7gcurXWQ47T/rwkR5ZAmmQaN9Ud
         alMVEu7jBlQ06C7hh3c3c27Q3fmcxUXdweUE+XTodE5fjF0kumWsc/VRNQpanzLEHVqj
         igt7HeAHo9WcDMNiBnBVNgTfQgy+P5C23ukSSfCqLO/LaXffnxaFj9Zb8l4aAw8EqtVU
         LmW5cemo+c/F+loA60hX0V00oajAB+W6XcRh4zDkiWXLRolKYc/Brm47D80g7Ugph845
         8rmHCfS27n9mWfQGSJ8RiFIeJdTrg8m0y33t/BH9HGYiL8+6J7iRSgigrs6br9uiK89K
         kRJg==
X-Gm-Message-State: AOJu0YzgqcFixfkGcU6qQl1zmzoY0foj4d9mgqDm4MYxh78j1qRNHSmb
	/3S5hoTRMvnm/ugZFtXNeYCu1ee0EDQIWPDiCfcE7EVnLFDSVp2xDZKFe/iPfBs=
X-Gm-Gg: ASbGncsXTyAk7KSVrm2W/6rYkEyKCTW5yQRuuMP0N9JWT3iZWqEyXyeHlrY9gsgZvIR
	O+t90fuYxz0ueSqPG/hA0V95gZl2IBN9yr7G2AXzQH2fK/id1il0vYbenwCvS4FV6KAtIgumeSe
	leUAzmy9KwKMIMEUP+291xM/oz5n/OJ3d1kTdBvQ6yxUy/eNMNKFYgpXwwc+QeYLHeXlVWF+YaT
	zbkw+inkx6c2evt6S1NV3NbdYsmsy/juYp/7Ogmf0ySK10nS+lXIh8IXL/dtK/CMoPobXivr2zU
	TKpokZuh7wxlqTXx7ZVcynjgwhfSV2Lm
X-Google-Smtp-Source: AGHT+IESHLGEGKFXlRphuw7k4dHFJulyQok6chjpaEQ1dtFzw0oCrtHmyg3O85lK0zb5h/yDUFAmkg==
X-Received: by 2002:a92:c26c:0:b0:3d5:893a:93ea with SMTP id e9e14a558f8ab-3d93b48e095mr4083015ab.13.1745545999562;
        Thu, 24 Apr 2025 18:53:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d93159fa3asm4985135ab.46.2025.04.24.18.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:53:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Guy Eisenberg <geisenberg@nvidia.com>, Jared Holzman <jholzman@nvidia.com>, 
 Yoav Cohen <yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, 
 Ofer Oshri <ofer@nvidia.com>
In-Reply-To: <20250425013742.1079549-1-ming.lei@redhat.com>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Message-Id: <174554599841.1088672.7136612395116492771.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 19:53:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 25 Apr 2025 09:37:38 +0800, Ming Lei wrote:
> The 2 patches try to fix race between between io_uring_cmd_complete_in_task
> and ublk_cancel_cmd.
> 
> Thanks,
> Ming
> 
> V2:
> 	- improve comment and commit log
> 	- remove useless memory barrier(Caleb Sander Mateos)
> 	- add tested-by fixes tag
> 
> [...]

Applied, thanks!

[1/2] ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
      commit: d6aa0c178bf81f30ae4a780b2bca653daa2eb633
[2/2] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
      commit: f40139fde5278d81af3227444fd6e76a76b9506d

Best regards,
-- 
Jens Axboe



