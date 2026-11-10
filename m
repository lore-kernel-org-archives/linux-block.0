Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311408;
	b=2q1b5ouPyFyctgViwLJFXu/QeFe4wMI78nesIEQzQXc+u1FzxX0EBXr9oPSnElls6jxF
	 mJ8/QucotP3w9AVQPt28mrpcjDC0Y3N86YnovJgBrBv8A/zeTApKlnxFLla5/9uEEdCtB
	 wN6Mj/0frZNKcZ8W36bbIPMxztMy8O9v1wnSLzBpyx/0tebLGBoILCPr/mwrEM/5rpDEY
	 +M05CaV8goj7PxFW7+34X9hoPIghbHbJTrUF9eJYTrPSeDduVXw3sYituofmCGtNM7Ism
	 GoZJseYKyTwMHpyi/Bm+kIJz9Ia18mhvSlI715bAiMWE0yd4yd0TfoihwtZEYLip8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ko4mREqmDAZGw+P8OhAmIBygelpZYVgRRe6KEoxcY3E=;
	b=Kq46gadzefSosPfkUQbztvgKmucTmCW+cM8ZtSCgdN8ZI5jdzopyoqb3bYtvwmLQezCS
	 8vvTsc1rKD52XR07o37mDUeZTlMRqArq+ldvqo4l3ateXqhblb+ddczfX6ZtESj2oX3u/
	 9w28piWPGdaMC1xQYG/LeRbYvBGlIDfulDrdYxnscnUMN9apPRE5+FOrIB0XihknNApfa
	 P6lS9z4qthPG3t9axeiS50W77JqKAkUfSBPteKLg3EpJvmY8v5wCJSn0mmOn7p8GWETwp
	 XrvaU1yTY+2tC2YXTFbxSuT3Bmg5pgFzSVG7uwP4bAm1tY3iQcFvwyzhZPXogRNP2sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crusoe.ai;
	spf=pass smtp.mailfrom=crusoe.ai;
	dkim=pass header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b="dIK/gln1";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9460A6F59
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 11:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F9460A6F59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=dIK/gln1
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso18594125e9.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794311406; x=1794916206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ko4mREqmDAZGw+P8OhAmIBygelpZYVgRRe6KEoxcY3E=;
        b=dIK/gln1mxXK5P4VKrMzCUbx/bd/QSfhQgQPZq5EOrhm6Et/mQUwC0RJibQmTJKSii
         rmJBXa8dtsLC5DBWe1+CTYfgKeTa0pD2orxGgMFBfwcF1RjNkkNf3h0UMhrCgopc0TMM
         +u3vVe7fOZHTmZ52511EHBaF9S3Ey88TBwxgV6xrcxJf6tm6lf27OECeNywhG5GBlSJl
         D65vgUtqgO04PcAeOhpFvtfOcw8iDBqdjXqKPz9lq63SQu0Yje/IgLi+EtpESXXhGwUS
         yav+lFtn6MmVIzCTbIQpwGlzNFP6YhORgOtQFu+YLRRxBuU0w1QS5RGGHYfz7iMF6zUv
         pJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311406; x=1794916206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ko4mREqmDAZGw+P8OhAmIBygelpZYVgRRe6KEoxcY3E=;
        b=V11fnNdb4kOf88Zr+iEfAA8XSgo7IWxn8aMrYvg1HTYuguyJqvGL+iGcOntDHVNVkr
         dO8LF+oRR95HD+b5G/gvItOH1TtK24TBv/0gGkvuSY+pocdszD/9e5fuAT1OWGue1ZUC
         BD8Pxxb4xVX+kxRhVfIY6cmymj9smfF06qmeczjwGY1LE6R8wbrSkgk+n/6gKkKGTYiE
         r1riZ87YOj36ie0A8VZ01ikLp2rlWZ8aRl9oNqjwxBwnsRzIqZjJOma9cVTTSDlHzGkH
         /TuK/tVuvfJ7KvomUftdONAtQPu5NHIdetftChx+DD+qO5D4WUL0wKErBv0xfbYGMe3f
         03Dg==
X-Gm-Message-State: APuU4Z+MlQ7rAuP2bXIkwR9GieKuF5ChTfxkvNbxpPm1JCZWv32gojkd
	+lbVoxxeHGGKz4eSOyzdNqcsgJ5gBOu8eGON7P/v+wXyzuVQq8Mjc384zkRLs1xOf2o=
X-Gm-Gg: AYBFou208EQt6mWkW0iagL9EUwH90yzHKzInRBV65gJ4ukyP0hdLy4pqlY3rBpb4sWD
	Tti06TpPO4rLlBL5xEGuQ9dQNjcGPYozJQ3IFTh6A2VcAiaFToQGhIddAiOs+UjnV2KcUT8R1ym
	JNO31QNaZd/z2KRrz6Uy5AHVJKpZyssxkWKMy3p5lAUGvKzJSKWLE+viI5yzGX79T6/cGz1i+TX
	YRX2ynVv/tZnDyt0BDzlyML2fkm5p300grIJ5IbtbnD9PpOqAgJN6FU9VbV0QbBZcmE46KskAAL
	NJ1ja8/g9vHLOAe45KGrQ4GKDDBeV5p728GHR/nYEt1jav971ph+XF60HGFZFIT+wcDYJapZVh6
	zFXt8Arz6ueIDx9E3SYgFKUj/ndpjK3fs3NvlKXo44eqTaKgJ1/ioM29Xg4l1exrSlTEO1TWRZj
	UQk57hVfCioe6VR43JUbErHnsehZIhSDQSkzjHfOBMtRFvjeKUyGZu6JehZv3/2d2Ohvu0j5AAw
	zhI412MWHWojIht0GKe/YvDT0sNtHqEfNXXAp9O+hp6CqfpoafSpttkCOy5sjD4PfSZL4f2UfzT
	ewh1LpR8Bjfu4BMGy2/i+n6q1lOE4YywbnWit+ICwTa4NUZULeyVQ0eTuPB0INsgVClryEc=
X-Received: by 2002:a05:600c:c166:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4ba0234e9ebmr38685915e9.27.1794311405845;
        Tue, 10 Nov 2026 03:50:05 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm4674805f8f.48.2026.11.10.03.50.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 03:50:05 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH blktests] nvme/081: test the per-queue io_cpu sysfs attribute
Date: Tue, 10 Nov 2026 11:49:42 +0000
Message-ID: <20261110114944.47206-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
References: <cover.1794015622.git.saravanand@crusoe.ai> <20261107095350.98072-1-saravanand@crusoe.ai> <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 09, 2026 at 07:13:27PM +0530, Nilay Shroff wrote:
> > +	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2
>
> How about adding connection option "--nr-io-queues 2"? If we add
> this option then we may not need to have the requirement of
> _require_min_cpus 2. I think, we shall be able to run this test
> also on the system with only one cpu.

I added --nr-io-queues 2, which pins the queue count. The test still
needs _require_min_cpus 2 though. nvmf_parse_options() caps
nr_io_queues at num_online_cpus(), so a single CPU host still gets one
I/O queue, and the test needs queues 1 and 2.

> Can we also add one more test here which tests whether "$qdir"
> exists or not?

Yes. v2 checks the queues directory and the io_cpu attribute
separately, with a skip reason for each, so a kernel that has only the
first patch of the series reports which part is missing.

> I think using --nr-io-queues option would also replace the above relative
> comparison with an exact comparison based on num of queues selected.

Yes. The test now expects exactly two queue directories after connect,
and a different count fails the test instead of skipping it.

> The reset test could be updated to ensure that number of queues
> remains unchanged after controller reset. Current test_reset()
> verifies that the io_cpu and managed attributes retain their expected
> values after reset. However, it doesn't explicitly verify that the
> queue directories were recreated with the same count. I would capture
> the queue_count before reset and compare it afterward as well as
> ensure that queue_count matches with nr_queue_dirs.

v2 reads queue_count before the reset and checks that it is unchanged
afterwards. queue_count includes the admin queue, so the test then
checks that the number of queue directories is queue_count - 1.

I will send v2 in reply to this mail. Thanks also for reviewing both
kernel patches.

Thanks,
Saravanan D.
