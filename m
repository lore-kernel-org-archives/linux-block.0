Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0B27FB1C
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539310; cv=none; b=BI4OBCiUeB1nx/YT7uVkqzNF5v8XQOR6Wl3WPnmykbQJ6jQIVpGcfGsKQSGBnVkkiHNba4TnI4SCuAfYzkkPVQjyTG3gglliQzS2qKsyy5H3hSPqxorlg4N2SXmyI95+ACQh707uorR8Jk1kSiNRz67mjOegRXIfwo6aXBkFCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539310; c=relaxed/simple;
	bh=Tb6BDZBE5ynIUE6E8FGPYaHXZNdYEoxWipboqKDEQwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ejowjvq698Eipaf/jlPgI5qlOdqOgFiToHeaGCqIrckYk4QvG7AFdbcdaCXk7zp7oDhTAFZ0J0o1tNWx9rHl7pjgRP4dbRDHAUzpLzcyj8CsV5yLVVLkFxeBrlFqYikxCoTtCoLVp5q9QgW3/ef8x0nTXXZrVETT2J/1bzsPWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rC769hNe; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rC769hNe"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d8e9f26b96so51175795ab.1
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539308; x=1747144108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBwoz+aHRGxXn7ZxnHnpYoInIULK5j/PPs1UON10CBE=;
        b=rC769hNe8rWvVSl3q3cKK7WI4igkGwhKI1no+gpUz19ml8Lca8/UqtlitCej4xAPEc
         JdgdPrD/BDqxC5Z74PosU3OjQ9NgabBu9uF9hmCTK7kYjfllMm0crR/ms3ZQHbBKlaEM
         RYGFD+fuGq3TyzKz9WsvRwE/e491t8A2I9d82NIZRi5J0JpdP2FnsB6i9YDc73Ht4Gkt
         SqU1O4c/UOluZMzi7HLli22rgJp+Rg+Tz/DZ0+68mCCzj/fMy0gVGJFg4H0Txzg+WRJw
         5SxiDxOOCKq9j2UdqbH90yI9nxSc/vuQe9pzrpayURxKbXmLg9OlOyaKyj3ip0GlUvdn
         94Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539308; x=1747144108;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBwoz+aHRGxXn7ZxnHnpYoInIULK5j/PPs1UON10CBE=;
        b=RaGTVTh1tkzHPhrD0q3ewZZ3UXE6ApA7KJvPfaiQBFdLu39488FRKK5fLeFQjtsz5d
         y3TR0jjOI9+GdM0qNPu7/avojA14K4cxbu7rJ26ueP6Pw79Tyh0bSaZcAy9+nx00nLdA
         ukOu6qUVZkgB3K0K5nYmpPD8XY062UmkX6qjKMphEWcRLvLzCXWPs3UUn80fajfd2z9y
         CtkiDQ62swRHyDrveAnreZl8DXBYmnRSVUEqZGLiDyMtF+XqwhwGHCfHhSrLf9wAeC0+
         U9OdNI8l0Ns++oxnwNNHzQGM+pr+/YdFbq9KairJBvlW1DNQ6LwNgm49Pr+dHsINDneA
         7qUA==
X-Gm-Message-State: AOJu0Yy0inSDeDuF4ApG9PaAcUl3NA4Zcbvez9w510Fxb+6Yg90Q/o6T
	capHSOMs00+IbodrXcZmD8QoRidRRnmE8IwUwPQLcfPIITXW6/W2sVvUbSuV9Uk=
X-Gm-Gg: ASbGncutBHzdojYAtbgWNDtnosKXzvAgcefaZDoAfLO22UxGgqhbbTRoUsw1fO+0xL/
	aU+nYQHlB8cNwKPbdH+G/wz4QkeN4M+HwWCzAnHJg0GLoUXDl/VPNCYZcrvfKBNUykpAVXA1xIx
	YliH2LK5r73mqt36GXCIyxqx+hNqgD9XCvd9SNlyiqDu0B/PxOcHGqW76QL/Eje7pgLSWAmtnXI
	NGvHt6VJ1k7wfYp9V7Mn/PQaYb2lpOKj/TGUOSL9m+iOKrREX+mRnW+vATT4aLRYCvbR3FRuVUg
	fZOfEzSkEZZTsprExVecFVkkXs85dcI=
X-Google-Smtp-Source: AGHT+IEE21mvb2NRofEoviu4BvIP008WvNE2Okcse6ABayhlAqHuIbaaTpXlIfGwAwugSX9nlssoOA==
X-Received: by 2002:a92:b11:0:b0:3da:7004:25c3 with SMTP id e9e14a558f8ab-3da700426a1mr12500775ab.12.1746539308458;
        Tue, 06 May 2025 06:48:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm25930915ab.58.2025.05.06.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:48:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5 00/25] block: unify elevator changing and fix
 lockdep warning
Message-Id: <174653930720.1466231.1085005593717678595.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 07:48:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 05 May 2025 22:17:38 +0800, Ming Lei wrote:
> This patchset cleans up elevator change code, and unifying it via single
> helper, meantime moves kobject_add/del & debugfs register/unregister out of
> queue freezing & elevator_lock. This way fixes many lockdep warnings
> reported recently, especially since fs_reclaim is connected with freeze lock
> manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
> show up earlier").
> 
> [...]

Applied, thanks!

[01/25] block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
        commit: f24d47edd1119b162a986bf1e88f30ec88c28029
[02/25] block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
        commit: 56dee46ff47f0ef9944dddd1fd137c94b7c2d9de
[03/25] block: don't call freeze queue in elevator_switch() and elevator_disable()
        commit: f8e111c859b92ee909f1676f90c791e7165d3860
[04/25] block: use q->elevator with ->elevator_lock held in elv_iosched_show()
        commit: 94209d27d14104ed828ca88cd5403a99162fe51a
[05/25] block: add two helpers for registering/un-registering sched debugfs
        commit: ed3896acdcf038888a80a02dd264099e35f76b47
[06/25] block: move sched debugfs register into elvevator_register_queue
        commit: 92c22d7efcdf92412ff70eb175d424d9c24ac07f
[07/25] block: add helper add_disk_final()
        commit: 5fad1490ef510e3b70ad8b0a5a1e28a26638a95f
[08/25] block: prevent adding/deleting disk during updating nr_hw_queues
        commit: 98e68f67020ce30e1a4d8e2d05d85a453738dfb8
[09/25] block: don't allow to switch elevator if updating nr_hw_queues is in-progress
        commit: b126d9d7475e3a35155f31418e54d9221b971ca1
[10/25] block: look up the elevator type in elevator_switch
        commit: a11abb98388e23188f3915780f3a193fdc1e4ff0
[11/25] block: fold elevator_disable into elevator_switch
        commit: 1bb7fba0e262e71f9355dc46c10b9da3c92f3d2b
[12/25] block: move blk_queue_registered() check into elv_iosched_store()
        commit: ac55b71a31a7287342e622c6f4de201e54b1c195
[13/25] block: simplify elevator reattachment for updating nr_hw_queues
        commit: 596dce110b7d543db727e6957ae7adf35beb0633
[14/25] block: move queue freezing & elevator_lock into elevator_change()
        commit: 20117b5a4b9c6dbb9414f0451111c3f13a37874a
[15/25] block: add `struct elv_change_ctx` for unifying elevator change
        commit: 1e9db5c42730e9ffd32cb922775de4873ec1d8ee
[16/25] block: unifying elevator change
        commit: 1e44bedbc921a35cb847991953814a50f738bcf3
[17/25] block: pass elevator_queue to elv_register_queue & unregister_queue
        commit: a3dc6279c2d5e2653b198684eb8857f414b6768f
[18/25] block: remove elevator queue's type check in elv_attr_show/store()
        commit: e25ee50dfab9fce77d2e0d89d2413b6c68015f97
[19/25] block: fail to show/store elevator sysfs attribute if elevator is dying
        commit: 5c3d858cdc57196e6d438e5ad47a732216e81a9c
[20/25] block: add new helper for disabling elevator switch when deleting disk
        commit: 21eed794ab4bd1a6c82a55df4416d18fb4d21da9
[21/25] block: move elv_register[unregister]_queue out of elevator_lock
        commit: 559dc11143eb468b2099b403d3a8d5c7fce32b96
[22/25] block: move hctx debugfs/sysfs registering out of freezing queue
        commit: 9dc7a882ce96482bfff3dba51dadcbe68daeac6c
[23/25] block: don't acquire ->elevator_lock in blk_mq_map_swqueue and blk_mq_realloc_hw_ctxs
        commit: 0a47d2b433ad275236d625b9f09c6d3672329712
[24/25] block: move hctx cpuhp add/del out of queue freezing
        commit: 7ed7fa561c357d1ff0d5938446662b2ea4b26bb3
[25/25] block: move wbt_enable_default() out of queue freezing from sched ->exit()
        commit: 78c271344b6f64ce24c845e54903e09928cf2061

Best regards,
-- 
Jens Axboe



