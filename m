Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DF17B421
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887101; cv=none; b=K2BlvzHEKyr2nc0FPIzVn+oDwQwVZu7UUUY9oZscMlAhEBasAgQY46S32teHILOyPYQr+pOmAEXbWPGNMEBHO//wihfFeRuqRBwsfL7/IigxLrs2Qzdie1nU6sKiWN0CVkRZYScOgcFhuPHJ5+y481+u9XQn9fauMdNU62YKOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887101; c=relaxed/simple;
	bh=1OFBVyXC74m7m30sNfKEOMRMxKhM0OL2/Hg5vCCpMM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6cEaiz4U31WVFGCklaNHfaeLY1TVHD5HgnGo1n7IplUEQjNrxt5XzBAl5zdDjeQN+nYqpD/6GiOaBpihrDjXSZL1kQKA2fHvYK6edzM+wnfhvnLf5qOACDZTiepgN+QiEoi3J4rnnf1wr/Xfnt3ILgZvK5zRy9zrUwTlDwrykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D+lId1x8; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D+lId1x8"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2350b1b9129so27200365ad.0
        for <linux-block@vger.kernel.org>; Mon, 02 Jun 2025 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748887099; x=1749491899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5oIn6bezGZLhayFBe0MNH+GsC9jrTsqQonorB1WcXhs=;
        b=D+lId1x8ws0OVfT50vDtNI20Szbknd3SQARul81+1+snGcItstGFCMaJZw8QKDsFZ5
         8BSXZFKqVssMvBaBtaZzIGuRDWxC5kCCSz16P+H9WsHtBhllISxW4vt6xVnoX5gQ2tAL
         a/i7q3T7PqaiopbJs0bL1IhOgmkAakmITbiWbTJ9Gsv9JnTMe/Mizyr5AnZNyxwrVL87
         Mw2wWDQK2zHIds+zwfHe+hA9byjyz8hUTf2bs9ugDDrIFEZ2B4rVlcXwP1DTn65lCaYR
         4Cp/+716U/GNKrahwg4jh2B6BkMNJ9FaJ7ASQ1R1Y1GPdvfEj3exsCG3EF/7v6prUxJ6
         IsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887099; x=1749491899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oIn6bezGZLhayFBe0MNH+GsC9jrTsqQonorB1WcXhs=;
        b=kB3WUBz4w/MNMZVcAdslGokgk8tMBSdiniGbgCZ67RnBHpfvTUWSJnhnE2p5SolI9+
         vpThrJmeg6fYVfaIMtRPa63HhAt9pjuqeiL+pSHl3Cj4Il3xuhoyOwyS46NhlXNLSWeD
         UwX9oP1dvxAwDp1HOUKIwZ4q2rR+JYNKeWpqT+WH9hxzykeBGvpf3ftjsMV3F1gWK6ug
         bYMCcQT6oHYjfTb9cYX5kmHqysHJJHNKeRBFyCUpy1mDo7of3S9omX1KIoDctYG4Q9L2
         xWCtUukPbCVwrS7oFhhsFuF9kWvs6OrJuUQLqNFkeU858DEVK/GBt+3ZXN/odoPewv+H
         tkCA==
X-Forwarded-Encrypted: i=1; AJvYcCU45X/HeoQdyTo6D+Ppc3w2GKRg9IcNPCOwglXjAai9NsW39z2yfSA1sc6HFzbLKi7GMXXl4D2BJR+WhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQzR5FgW5mqA7yg1Ccsg+8h70wpVBNUgaA5Ht7Mk1ppo7bQkT
	UGb1MR0lYyNR23K/707jAtYDcYKu19USb1oBLjO+TPil7avqNHXqVJ09V2ErRB88dK99OfSl+L4
	X22eQlIwJQxtj2NWedmh/jA7l3N91w8kHkKa/
X-Gm-Gg: ASbGncvkte48QZbRPnR+lwmcgcExut3DgbSM5AQYVuFfui/iTeHv/C1PLQQ3iHlY+s2
	NrGpcwtrjZ15gvWNrE4F2Ucs1bepcgyL4J3QbofZhKEPp31Vn1ky0Wyq5uFnJa7ws20rzlD8M9B
	qWnNAFpTXJ2vZ0lwuHScacxc/lyrSQgZcvzg+vVua+ipTMcXsLPGBPM9xtC7ZmFzU6guqqLNJO9
	7QSOI8pKx/XIOc2vgRz+kJJNbjDFgBFtJ1Gim4/0NYsZq+QJbyn2luy3F5i6FYyGYXJrDeekNX2
	WRjBqtvr4NRn5JYbv/WNmYsjvm8SfX3zosH+3D2Bb9FAVQ==
X-Google-Smtp-Source: AGHT+IHCs+wpcjFX6bhloSOdnQLRQ00RHKirokluvcsy2cYeteVDcKQJONkyi5e88aVjRMW5/YwD5yBAj0gn
X-Received: by 2002:a17:903:1946:b0:235:2799:640 with SMTP id d9443c01a7336-235396ac9afmr177374705ad.25.1748887098999;
        Mon, 02 Jun 2025 10:58:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-23506d37da2sm5832125ad.88.2025.06.02.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 10:58:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 17A7034014B;
	Mon,  2 Jun 2025 11:58:18 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 013BAE40E80; Mon,  2 Jun 2025 11:58:17 -0600 (MDT)
Date: Mon, 2 Jun 2025 11:58:17 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] selftests: ublk: cover PER_IO_DAEMON in more stress tests
Message-ID: <aD3mOZSF0jVJnskF@dev-ushankar.dev.purestorage.com>
References: <20250602132113.1398645-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602132113.1398645-1-ming.lei@redhat.com>

On Mon, Jun 02, 2025 at 09:21:13PM +0800, Ming Lei wrote:
> We have stress_03, stress_04 and stress_05 for checking new feature vs.
> stress IO & device removal & ublk server crash & recovery, so let the
> three existing stress tests cover PER_IO_DAEMON.
> 
> Then stress_06 can be removed, since the same test function is included in
> stress_03.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  .../testing/selftests/ublk/test_stress_03.sh  |  8 +++++
>  .../testing/selftests/ublk/test_stress_04.sh  |  7 ++++
>  .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
>  .../testing/selftests/ublk/test_stress_06.sh  | 36 -------------------
>  4 files changed, 22 insertions(+), 36 deletions(-)
>  delete mode 100755 tools/testing/selftests/ublk/test_stress_06.sh

This should also remove test_stress_06.sh from the ublk selftests
Makefile. Besides that,

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

