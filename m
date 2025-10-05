Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879663B9;
	Sun,  5 Oct 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669378; cv=none; b=rk3RgWTh9ajrK+2upkf5fpXdaZ0XMqSwFj71wx5zyuWeglAVV0eGZ82D5A4JJ4fGwd659gRSxd+JouJZJ3MscSv0FmhPe7FKtSzjsPyhP7rV01nbZmJVgvQCTJAyTWhd4qI4nY9re/azhqhkmZjH7ihwuCBUPadBZfJXJeL8/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669378; c=relaxed/simple;
	bh=n2M5dcj70a5ht+OXZH9LHIsjp1kCGDATX0QKyLISvLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZgyS5QbNHhifvA2C0ZRJVj4dHK7Inz1yAVlHzEEjd3vF7oBeNoHVylcjD6T5K2jWS8W8jxmSrKcXt21LWmwz+4jdA5aglETatwFNQ3q4EfDEms4xDw/CxwHUGJrqhsm2MZrsqtFjBlbm3JH2AjPKEbQJP4K2eS2qubGTqavs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <wangfushuai@baidu.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop: Remove redundant __GFP_NOWARN
Date: Sun, 5 Oct 2025 21:02:11 +0800
Message-ID: <20251005130211.30093-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251005125326.29432-1-wangfushuai@baidu.com>
References: <20251005125326.29432-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

>> The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
>> 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
>> remove the redundant __GFP_NOWARN flag.

I see that Qianfeng has already changed this, please ignore this.

Regards,
Wang.
