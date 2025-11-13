Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8124E4A1
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014728; cv=none; b=Pzs1VuECkGmatPyDS8c+IDin8bw9f7imgkMzV/tCiQG/u/b8b4+fHkNZ26wUzManz/b9YCuz88FtwLON+am5hfj071e3ipIaqXlvxb7QJkD4JSCkCb1tZ+U4ooxvfdpp2nWr2lQQ0ZxwEbrGAACIIZDqDlYMuxmd7k0uiPh4grk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014728; c=relaxed/simple;
	bh=CyocZjHQhaswp7JoiAlKvEWE5vH8tCr4gkcp2Ph5NYM=;
	h=References:Content-Type:To:In-Reply-To:Cc:Mime-Version:From:
	 Subject:Date:Message-Id; b=tXId5qIF61PAJbCQZkyg+omlc9IysV+aZNTmBwtyJFHhL8sAE+zV3da957BOPpY2I7iSjQnAvOrvPOkaZRb/iQuolf2U0yZhHr7VeX9mWrSwDqtt4Sewm3h44m7aAaIPdN3WaetuwtPNFUr+yOvt7hSqxOWMieKQ5qm2pt6H0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=npwYL1Bn; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="npwYL1Bn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763014713;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=NJZBlRCGTvLtyxwHa/+gBu7c0agULkd8t619ZjGIOCs=;
 b=npwYL1Bn1u8TPF3127CrukqgmkN6BC4fHfDh2x9dMgG87isa0jliynjDoUmlrc4TsXkgGb
 Drm1x6V/pakQrRGXQJq7VhI9Cn2u8eLVNKl/8Buy3kGdJoPXOZZXDAOP+e/IpLSWTJWXWW
 JrD/Lc9tDTF3gFLjCTWvCMyCDJnENHohNy3uYRIanhB0gcvBXKt5WWH4u9aUg7mP9tmjQP
 8ldGRP6fSgJDZMDhtNE0ADdIk8bed2vTIcvxPdmeKpnqckja5LwV4LVoYmdW2+dgKvK4gH
 fUA5tLdwdMlzSxqVlu2R8mqWbiNsq2MGlyEs1NoQQooxlK4NPq4yJuUvKR/+3w==
References: <20251112132249.1791304-1-nilay@linux.ibm.com> <20251112132249.1791304-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.130]) by smtp.feishu.cn with ESMTPS; Thu, 13 Nov 2025 14:18:19 +0800
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
In-Reply-To: <20251112132249.1791304-2-nilay@linux.ibm.com>
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	"Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCHv6 1/5] block: unify elevator tags and type xarrays into struct elv_change_ctx
Date: Thu, 13 Nov 2025 14:18:17 +0800
Message-Id: <e328f6a1-a097-475a-8c67-74c01698fb8d@fnnas.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26915782c+fc974c+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com

=E5=9C=A8 2025/11/12 21:22, Nilay Shroff =E5=86=99=E9=81=93:
> Currently, the nr_hw_queues update path manages two disjoint xarrays =E2=
=80=94
> one for elevator tags and another for elevator type =E2=80=94 both used d=
uring
> elevator switching. Maintaining these two parallel structures for the
> same purpose adds unnecessary complexity and potential for mismatched
> state.
>
> This patch unifies both xarrays into a single structure, struct
> elv_change_ctx, which holds all per-queue elevator change context. A
> single xarray, named elv_tbl, now maps each queue (q->id) in a tagset
> to its corresponding elv_change_ctx entry, encapsulating the elevator
> tags, type and name references.
>
> This unification simplifies the code, improves maintainability, and
> clarifies ownership of per-queue elevator state.
>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 76 +++++++++++++++++++++++++++++++++-----------
>   block/blk-mq-sched.h |  3 ++
>   block/blk-mq.c       | 50 +++++++++++++++++------------
>   block/blk.h          |  7 ++--
>   block/elevator.c     | 31 ++++--------------
>   block/elevator.h     | 15 +++++++++
>   6 files changed, 115 insertions(+), 67 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai
