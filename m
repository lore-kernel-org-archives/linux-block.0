Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDD2741A6;
	Tue, 18 Nov 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454121; cv=none; b=Qvw2RJpwO7WiES0KM3TLIqJJQkMyExdLgnhTyVvQOogIED5ZOOLfQ5zfU98L2N5pMtkorqXk6ZwFbh+jHr7JwMp6S/1bHvOeXmGAipT/3K64UleK1/4kRhXx7vhCNvbabr79zfQjZFxbwQYmCbV5HsCThmzFiCp68ZWgh7Ni/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454121; c=relaxed/simple;
	bh=D7DPGFKVy0s48PVy6E1rMZw7G6d6Aqidjr0SNy6c4rg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=M/3b0tcH8WgY5FKM66sLtdJAybDbU9+DosrPgdVImSTalYFd5HnDDN8TRikY+PoRMhJV6GAuyOYfSCSWlW3A4yH/uqu6OCEctNojdaEEmmL0bdX75eomGSHsjkijLCRSyCjbnp9ITY+DJnFkPCiuMn1KecJJwObcpNR0BUJWFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=lDJcrCbG; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lDJcrCbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763454111;
	bh=D7DPGFKVy0s48PVy6E1rMZw7G6d6Aqidjr0SNy6c4rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lDJcrCbGDutEvKP0OiWcrR82AoANoNRq6lwhx93tbn72Yw18s4at9aUs8muSDR3Cj
	 a0hK+a7an92X+eNM5kJT8kFYxBgJO6iifM7PFVbuu0NdbVpICmhw+llx2BjCbW6ntK
	 h26kMM02Pc1xx3YpTuBsI0BAOK9Bs6vQDDCikCB0=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 57003039; Tue, 18 Nov 2025 16:21:48 +0800
X-QQ-mid: xmsmtpt1763454108thf7bnbho
Message-ID: <tencent_C4669CD835EF1C2ACFE58BB30BA60886BB05@qq.com>
X-QQ-XMAILINFO: MwSgv9IoJFr1DNKAPmLPPGkCSjO832gac+Nkob40cHLFFVFi6viG110AHX/lJk
	 MR9qQ2zKu7uIFRMc0T2nSW+57D3Xe9ulEwPrRvi2gv5kXyOgECUdJZMP6ZFF4dd4F0l4HiQwiRKe
	 DEjO+5Kq4SRUfaM99XGjI6gBcOhYjnfJ28Alr++Rb/wQPQdcmA0MZXEK4V5CKM7+Rh9TLsLEOi8w
	 CSj3lokmibcIMtWKnYaEkT9pDVj2hACBQJS+XhSoa9qnmhE0tWOoz1IPXyKUlXZgCcnPVRkcMi6B
	 P4f1OgVdTiRqfxUzfjAfmYhWBsyNNjY/k6OTMZUVoLgB7+XKC3f4EqkwAjQdQHQ6Hcj4G/1cmSn/
	 jXmuM2D8gELGqM+BoRv/RzhM2hQMX3Z9kOuTMsWVBpimU8T9BjAikA+UibiSG3VjZsDkvaVs6qTF
	 l/LBgYw9bnZ+D9LmrEP3kp9Ryv5SZyMvPZiQevfFPCT+Gs1Vlq/Kv0NxdgRUZuZn/+P3ZR5z+DFr
	 m5SJFlyCfLOfov6ubPg0pZwmpU7/s0Mqc/KEg5lEWXtafAw7zCBOLK8fn3LI8yEpc/COCBSA2Gf8
	 VQJ1hetHYzQodeBFtOdu/TbWi0JZ17Jfh/owuCMAAvl/gGZDlbZtE0nJma+jjBgoxL5OrQ6Uerd2
	 W7Tp62zENKbTQyhmkbxHB47XkK7dlmLfxmWD90aIa8NkwxpUH3+pCKwxeaHNOCL1HsX6TcBXUxOd
	 Z1fhagpZzP48TMF+8Uk0OuFY2TA7OZAn075dA7PKgnEO9nB5laVJTllbXne5INMGGwiO0EqECSBG
	 T45OrFcPAmuOzP2LSGkXuJrjq6JJyC0Ia0N+LknC3nRjexvrnPxGMTQnIi3b2OYiRdoKqC1PqbX3
	 XXW6k1K11kHfw5XS0C9YcKZYdC2ihpP5N8FA//xG6HHbX6MlPB6sCp82Q64e5UI4pCSYTH+fboEt
	 GMZJZR36Wy73ZU0FtKn+Li+/PbHZwWnOw5T6PjoZ4WzIz9zEEW8ZwMXiWDP402DsbRP4oITO/ynS
	 9UtWqZBjwN+45cspLEDMXV/jQM3iEoZy6XjAyNxqrcedUqEsEyAnwSp+X1tpaFHXaB2eVlo1y07i
	 pKFvll
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCH] zram: Fix the issue that the write - back limits might overflow
Date: Tue, 18 Nov 2025 16:21:47 +0800
X-OQ-MSGID: <20251118082147.2809308-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bo4g7erropsvl7vulufdsjqlkkbjycaounh2vv4a6urttxvubr@f22z5wlgntox>
References: <bo4g7erropsvl7vulufdsjqlkkbjycaounh2vv4a6urttxvubr@f22z5wlgntox>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On (25/11/18 15:39), Sergey Senozhatsky wrote:
> I really wish we could just change wb code to use PAGE_SIZE not 4K
> units [1], unfortunately it's probably too late to change that now.
>
> [1] https://lore.kernel.org/linux-kernel/20251110052741.92031-1-senozhatsky@chromium.org

I've taken a look at the patch you submitted before. This is indeed
a very frustrating thing. I'm not sure if we can make the change. If
we can change it to use PAGE_SIZE, it will reduce a lot of unnecessary
logic.

