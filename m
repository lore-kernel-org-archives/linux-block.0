Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9426F28B;
	Mon, 29 Sep 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150505; cv=pass; b=Q0Mj9c9lHhp8LQa0gEy/qS3y+JiE5IB01FgdOAnZO7L8n/A6h/hBXiEXyYUP2kZVjisajt5nE8sBEK6F4p87Y43jIt9RQoG7XidW/cVJ/N8Vne9Rbs9OSc5Hbx9UfzjM8qiXNy7gcC9Lq1g5KRDHu1XOaf2uXPWghT/y0aDJovU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150505; c=relaxed/simple;
	bh=eSeLRTMxZXO+xEsTElQ4qYu1mYZMdSRe9Fn4UbD77g4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rFBjUW3kpa1EKFtfffuiKNqROuen3Wk5F1gJsz7VMozyL07ksUw1NEZkp67LPCi7qPHJqSDnRxdM902i613UzxGlRvKt9nj90zXzycvz536pIFovDCEbOpwm8e4WdW4H2MGRb4fvCfQrgU+phA9eb5FHdkWkoFLwqCtFPEKj7k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=S5T1OJY6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="S5T1OJY6"
ARC-Seal: i=1; a=rsa-sha256; t=1759150491; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cF9k9RZ4RuAUoq1KIBBVL/wC6Lwapeqri4XlrLeN9PITZSkInDJ3IActvs5StAHs6joLVZIuyXCWxAGJL7rlqR6VIqUmW4VyR7n7P+ekgkLhlaLsesQAQKSSZcO64CWf07k7NGeYLqj590JVcA2JvmneOS9KITn8z8M/CMaWR98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759150491; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=STfaXr/Pv+yP6vfK6KrqleezWlxV7mt5xpR4E3dqUjU=; 
	b=eOllgyOuAhfasMQr+H0boa3ma5ZqpG+aKovQkLaycNE01hBcubQw7wBGjiIwWos+EvZynYAuToUvC1JZnq8gzVGO8cbILT7D0Bi5/WURrYCfoeC6dOBT881S87vTK2atxBh0i3yShe7/m/uk71tBkUIMltDAjYNrxVDe5V9WEH4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759150491;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=STfaXr/Pv+yP6vfK6KrqleezWlxV7mt5xpR4E3dqUjU=;
	b=S5T1OJY6o3oGepokdEDmed5LbCI3QNztKDRjrxiGUunV/G6Bfsp1rfLCCiFp3c1D
	dTeSDm7tzO3UZlA4xhG9OgFZaIeokJPKMdFYp5te+F+0TKuIeUKCf2O2BMkDGEMCS0a
	Z98CL9zjYYimMRrX7hoIWTxcYTjzbrLdDKYIm/7c=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1759150489101679.6535712839434; Mon, 29 Sep 2025 05:54:49 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:54:49 +0800
From: Li Chen <me@linux.beauty>
To: "yangerkun" <yangerkun@huawei.com>
Cc: "Jens Axboe" <axboe@kernel.dk>,
	"linux-block" <linux-block@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <199958a3dfc.76910e49549391.5634075750839417784@linux.beauty>
In-Reply-To: <342f5e80-40a6-0fd3-7ac2-9b4dcd5461d6@huawei.com>
References: <20250926121231.32549-1-me@linux.beauty> <342f5e80-40a6-0fd3-7ac2-9b4dcd5461d6@huawei.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation
 error
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Erkun,

 ---- On Sun, 28 Sep 2025 09:54:51 +0800  yangerkun <yangerkun@huawei.com> =
wrote ---=20
 >=20
 >=20
 > =E5=9C=A8 2025/9/26 20:12, Li Chen =E5=86=99=E9=81=93:
 > > loop_change_fd() and loop_configure() call loop_check_backing_file()
 > > to validate the new backing file. If validation fails, the reference
 > > acquired by fget() was not dropped, leaking a file reference.
 > >=20
 > > Fix this by calling fput(file) before returning the error.
 > >=20
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 >=20
 > You'd better add a fix tag:
 >=20
 > Fixes: f5c84eff634b ("loop: Add sanity check for read/write_iter")

Thanks, I would add it in v2.

Regards,
Li

