Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89B33710C;
	Fri, 21 Nov 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709312; cv=none; b=nmyds0MpZV6n+FUCfKTZjMLpijs/ow4F9qezYzslcI3XP1jPwAj0xJ3ClIjIkB+eBlFdyWe7GkpUJhhm4embYnqtI6mkTYvd5vT3x8jK7HkvYEFlUI0iiXodZjdcOFWYhWHOpEdFRTQbTM0ZKiYTJDCjRI+nWTes7CDeMTV7lGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709312; c=relaxed/simple;
	bh=/DwHlbEiftY1w8J4nFYbGuKtmkmlqKwUp+1PA/TZymU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=d/U5SAg6XhSwkzela5BLXOztJU1UiZUppuSIqZ+/s3q2g/aSthaUaleynK4HzUd/hfAaiANxJZOx9WOtMBSkiruZyLjbqFZVZ0HTvan5vLfxYmxm03CKkUZjF/5Xa+ZxU59YqCYBw4z34zZtBohBockQOpiJIGqobYDAc4tF+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nnE58/jB; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nnE58/jB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763709298;
	bh=XIXqlDrtPhMmpwTQ8EsYrSQr66/V/dN5uVlu5UxsaNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nnE58/jByThWTH2D861d1sosQUHp7Hp0zPJcoytFsQ1wpTsHHYbhx9w+7bbxaeA6y
	 8oF+JvZ+gN8e+kgg/Nn+alGzx7EFhowK/07fdvSaFrhsRRXeG8Lz6WArEnW23EA9/W
	 KHofrWF2AFAZyJ8dkuLaKmZZTGuxw0khd4B+wpaA=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 3B700E79; Fri, 21 Nov 2025 15:14:55 +0800
X-QQ-mid: xmsmtpt1763709295th2m2vzwp
Message-ID: <tencent_301571E78C8FB8CE9FE3E5857DC174E5150A@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPRRIugqvnJvF10UIOocD22inf83ArdpNR3mPDYc8qMEZdSLIt5i
	 HYY8enqE8S7hNKhgtFBoU9hG0S8U5u/+MhiQVr7Who95bvGPbyKPwqC52CLEmw4JDWIo2xP7ugdn
	 i5c9kO7+crS2kpqxHnLvzlWN7f1AQPLUmYFNOC6pytDhuCMCbCFHA/TyN2Wn21I5wNYundIEcKn/
	 cuvzoVC5ixOoQQ4+ehdxcbLPM/QkFSWOp+g6vAKOPdu9nVW78bnRZ1nDidZKATWohBkxuexsKH8n
	 79b5TUg+i79H0nivXfjzQfaji8l4HxSAAbol03QEWJhgBAYSe+gqI7djAuQhSl3Orw6+yGKw1gYZ
	 7QEVPv17cf7JUSXVH4Rx0L4l5MTdbz29F7V8BAGOBF9fBOKnug3L2MKDvOr/FAwsYUEHoSiu8ipK
	 62tvALA6dHLi7/tTGlD7/896pXYUo23WljoosgaPedPDJ7mjKqfAOXO+prZnihMdspjf5Q9A++VJ
	 +LF0C90ksdFh9WerO0/y6WlZHGHphmEqrvu1tx/g44OFF2LiBjtTDk/ncJhk5OTgKeLKFs2ICxfO
	 hjIMoLiMK4zp6aY17z8kVZm3Yh2IZlmjRo9eYSauT95tjy5sxBlxqQnzWCybT/ZkmAshKFBoGLQl
	 4UGrGm9PX6g8sByc7K93xlNvRt6sHllYqC7OeSgm5HDxaq/v+Mebsuci0U5aRocFvQLNHmphXZqT
	 u6yOaMETAi1vjOGbIBZugN07h50Y1zPOuleEDV+rYF+eAV+iBas5wqlyoK+U8qlwNLpAWyaaLK/4
	 xkFn+VYWpji4WfKSiaGS4DDCTIK7mQtfCLDt0cWWYUGEpnbHw0Lt7kY/303zFZO8DhTvX9zS/zGQ
	 xyv/nNjY3Rb/yeTh1OxOJYRu59wo/syYZxyjSYYx1R7LeqJrR6S9LUl95cFlJV2D7l9Wsi0Y9Ehs
	 nceYyjuEe4jZ2PBnEDJlHY2IPm1a4UM6XznX2ZvgJPUGzZvmsUDMqYrQwumTND6jEqKWz7z042we
	 Hg0bNfuV7bCLKzQ6Re0e6er86/QKtxiSuyGXtN4SQCI3BJMwe+RNVql59Wmho=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Subject: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Date: Fri, 21 Nov 2025 15:14:54 +0800
X-OQ-MSGID: <20251121071454.2999571-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120152126.3126298-1-senozhatsky@chromium.org>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Nov 2025 00:21:20 +0900, Sergey Senozhatsky wrote:
> This is a different approach compared to [1].  Instead of
> using blk plug API to batch writeback bios, we just keep
> submitting them and track available of done/idle requests
> (we still use a pool of requests, to put a constraint on
> memory usage).  The intuition is that blk plug API is good
> for sequential IO patterns, but zram writeback is more
> likely to use random IO patterns.

> I only did minimal testing so far (in a VM).  More testing
> (on real H/W) is needed, any help is highly appreciated.

I conducted a test on an NVMe host. When all requests were random,
this fix was indeed a bit faster than the previous one.

before:
real	0m0.261s
user	0m0.000s
sys	0m0.243s

real	0m0.260s
user	0m0.000s
sys	0m0.244s

real	0m0.259s
user	0m0.000s
sys	0m0.243s

after:
real	0m0.322s
user	0m0.000s
sys	0m0.214s

real	0m0.326s
user	0m0.000s
sys	0m0.206s

real	0m0.325s
user	0m0.000s
sys	0m0.215s

This result is something to be happy about. However, I'm also quite
curious about the test results on devices like UFS, which have
relatively less internal memory.

