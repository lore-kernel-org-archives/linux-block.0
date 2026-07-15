Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF437702B;
	Wed, 15 Jul 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125556; cv=none; b=qBdv1hZ/OBlDQMscQJH4KRtTRr23AvGoLglHhOkA0ZFS5Z0zVh/8hU05Vy/J7Dtk7Ji7h7XYzgdan8oNk5VEpAzHi+00WKC4j/6oy+UyMcMMf3ziIjODRrb90ECEBB+ZpM4VG4iLMzERAFrK1ZApWLnkwQJj5xld9esZUhWdLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125556; c=relaxed/simple;
	bh=BpdKHY4YF2BScseXVJHpIiTYg/7j3O+DBZF4QNA4EMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWHRd37uVLkqmMZROtsTqwjkOpsdb1SHG/AXszjaDaXSPWdfKsp3lu145mhhW1+ZOnAPqNGZocI36lLfJfTFLF6q0owOCRCs4MvqCrtT7wXGNVZLkvQe7HY+gf6VrrItq3YVV1v1y/QyZQmA2XH744332H7WsRoqkhPppHoEeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 66FEPf4j036310;
	Wed, 15 Jul 2026 23:25:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 66FEPfc7036307
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Jul 2026 23:25:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <564105ec-acee-4178-be9f-077f783c1122@I-love.SAKURA.ne.jp>
Date: Wed, 15 Jul 2026 23:25:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [loop] d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <202607151655.9d74999d-lkp@intel.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202607151655.9d74999d-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

On 2026/07/15 22:55, kernel test robot wrote:
> 
> hi, Tetsuo Handa,
> 
> this report is just FYI.
> we understand d908729e74 is an experimental patch, and it seems there are lots
> of print while running stress-ng.umount tests (one dmesg is attached)
> 
> [   59.370110][T10457] do_umount: task=stress-ng-umoun[10457] propagate_mount_busy()!=0
> [   59.394831][T10476] do_umount: task=stress-ng-umoun[10476] propagate_mount_busy()!=0
> [   59.404989][T10477] do_umount: task=stress-ng-umoun[10477] propagate_mount_busy()!=0
> [   59.414578][T10473] do_umount: task=stress-ng-umoun[10473] propagate_mount_busy()!=0
> [   59.423911][T10460] do_umount: task=stress-ng-umoun[10460] propagate_mount_busy()!=0
> 
> ....
> 
> 
> so the very slow performance is expected?

Since printk() is a slow operation, stressing umount() operation that fail with -EBUSY
can cause significantly slow performance. Can you try without fs/namespace.c changes?

