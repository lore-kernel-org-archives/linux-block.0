Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F2221D92;
	Fri, 21 Nov 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711115; cv=none; b=c+xQtyhuuQOK20slH6jB9YziNpbt2Py2oNmxpoj16xaZFHTjZME9YLA8+BskE+0IG1GPAIigWoljvJiFKzWz7D72/V2zzaqXuJgyXPpSdPlx9ODpWsDdv6xgsPA8bfyykIAKU/XPYYHRlk3EAhMp+49wX6sPC4rQCmrS6FYqRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711115; c=relaxed/simple;
	bh=JE8n4ef2V3IJTTEd6KB/XXyiRp4NHkcmBEBh+dWI+Eo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ad3zt8os2Ptlrjiz+geK/66L7rS0IGO4bq7pxvqKqDK9ALTN5nhj9H05C4uFk0OvYOGV0JZDLY+hCSkIPwpHW9xPwVv+M1PjnInDGtDnkA3m5MLRw+wYLYDLqsKszstgp0ilG3YMdvBYvO57B5ejpcMxXNdBMqEIPdxZIPOMt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=OaV0nAYl; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OaV0nAYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763711102;
	bh=JE8n4ef2V3IJTTEd6KB/XXyiRp4NHkcmBEBh+dWI+Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OaV0nAYlcKk2X/m58z8OrlcGD3Q4LqZ8Fs7LVdOMBRjMRQKOCSmBQ3DSD8/pnE/+P
	 CkIPtQM2P5aTyxLmCVWWmyuv+hLUJVNuVZO3S0ZLag6X4/YH1JmCP4QGsl/YMxRdW+
	 yCT7/qTXY5TBYvf/kujez6fd6yluVDZ3tqzSV+2M=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B3BBF8C0; Fri, 21 Nov 2025 15:44:59 +0800
X-QQ-mid: xmsmtpt1763711099t8hwyz0vd
Message-ID: <tencent_7F5D453FDCFFE315AE59E73779635F865D08@qq.com>
X-QQ-XMAILINFO: M+6QKz8nsrJQcV7g5GXCXdXddYR3xutlAzsZVSuzte29feLFnTOMxmAPEh9kNF
	 iDDT3V2c5wgSVJkE/ig65ixOvVUbF4jFsJDbGnJtVXftiC8voG+nJ1gMX9glvPqdrknDM9f6WT86
	 vOxTMfql5WwcArtW7X5Hdk5hHgKQqlVblqg72Yb+eP37HYVbuVIRxz0uZ0yxtWwfJ+fuYb6YZ+MZ
	 p1zenSbyTzr5nk/0mqz3RqYqRMXi7CuNFfUHY0sqzRcwyCi+2uGT++rWItcHPzbZ+n0Mv9+PG7/g
	 BJL7qXFHhJfZgqXifzMY0sNidPjG7NOCLRAiO9T8qLnrZ/ZYuO8WCkwepVmaaRMOoo23Ki3rjdkC
	 VPtEEEIEfMJC8c5JB6DrLbBS0pMVEXIdGdis99zvz+iLAgXSOh7pwRC85m1D7R2YJK88wT6lvQAA
	 4yaPywPBVd2ZgckGZMQbCMv3xSyakKIKu60fMxqDc98depHRS4PK+A0BjMgGI5Wn3QPe3krwE2of
	 t5Kh1WWe5Hetwu2jDmFocSdkidVidFQHpKHh+ylcqTDrT3Fsxn6no7B4ChtDZa91vX8ya46ikAif
	 Gc1gYUVvd4Dtq9Ln1kqa/QViYhPKgCPJiP65b6jc8vMf05cWim/XRR4T/6aLFwHjPWN5KWvOkF8Y
	 vjdC4O+ADC3XKKJ1rQ4tn5DcKqepDb2QaU87xKj7hF/DLKoIjgwu0+Nb8HXk2EQDlcp5gR8rFeTe
	 tusEs/CKE2C1mDl7kD4ExmjrE9Ehc3uPI/6xDnf1eWXymidYrMKBauo03sW2cY0w/jSxu9BaBoG/
	 EohW+UgeEDvZvn9NQn2gKQoSVZDeQ+La0qjGxGvb6n6LsxGWaSrVP1ht3cSxTwq24ePwxL8Pms/S
	 woPi0ONgLsaEkR14q8BGgPxOKkPUawuBef/Z9FjY+PlCJ3nZT1abP3SGUW+9r97NHPepb0pEhM3C
	 fIU5j6M8yeo/zHTWewXSd/Ux/B7zmK7BVacfbYLd64Y/F4bsDM1GwY7jxlfNRDgHAF/EmRkmsS2j
	 dveR7kHANYytpKUZHfXbKcLGuWvWuLgaj4yLiuoIbNqWXgPlwzoMp/j4b40FV2tXA08uP0dijXGt
	 lQrjpHMXlLnShJbWysHOXMmLz+5T1B0UfkxLvY/cpixufx+8I=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Date: Fri, 21 Nov 2025 15:44:59 +0800
X-OQ-MSGID: <20251121074459.3000341-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <upyms2wnksojg6ix7dha74bjm2gfhv6ieef65k3f2our4r6fp4@kjtpmu4mtbay>
References: <upyms2wnksojg6ix7dha74bjm2gfhv6ieef65k3f2our4r6fp4@kjtpmu4mtbay>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Nov 2025 16:32:27 +0900, Sergey Senozhatsky wrote:
> Is "before" blk-plug based approach and "after" this new approach?

Sorry, I got the before and after mixed up.


In addition, I also have some related questions to consult:

1. Will page fault exceptions be delayed during the writeback processing?
2. Since the loop device uses a work queue to handle requests, when
the system load is relatively high, will it have a relatively large
impact on the latency of page fault exceptions? Is there any way to solve
this problem?

