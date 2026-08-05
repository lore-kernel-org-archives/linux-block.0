Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207601A682C;
	Wed,  5 Aug 2026 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890651; cv=none; b=FGs3BDgDRLfp5Dyu1/UHauJqLUJjdr4a3R7hf9BV+PXFY4BZOLN+cAjMD6i8v6/XBfQ2lUZCbhJh95L5+cN7dGSfs1YzXTLIb41yFBzxc8A1HCPNzeJbRKQ4+BU3Kh699+YyE2YG9UpxPfkGKIo1XyhqZV4/8EEZLlQcy2HHkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890651; c=relaxed/simple;
	bh=A/KaithGFpCu/Xix9Ievp82PIz5fUqa2CmC/L4wSBDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftbgjieW+OeYi+ASEsrL1+C23m/apt0IFAuACJoA01thAR7JQPcp63+h+ymr2b6z0p9lPPwgLRJLpnSs0OEDU+u8oJKsIlBQpdTqZv2ZnBCcvQkOejKzsIG8wDur7vO/HKZmensuJT+GcUwiigThC9g0X1+t4mkbYaLa2g5QDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gAIW2kjU; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gAIW2kjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=A/
	KaithGFpCu/Xix9Ievp82PIz5fUqa2CmC/L4wSBDA=; b=gAIW2kjUN/l8TcJt7I
	nyVN22iY470B+XR6umjut6WysFiXO1/74CGCitem4qXM506nJdB68yCg0NgrTy+o
	Rueh1xTVJlBj7MQwuF3ZKol/J04HaiNLJZmJkzvEDhaIMENTQp367/9AyVpqxNgs
	5I/e/hIGscAcVzgBKM04uaSPQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wA34ewzh3JqJqQfMQ--.61178S2;
	Wed, 05 Aug 2026 08:43:32 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: add rotating auto_buf index regression test
Date: Wed,  5 Aug 2026 08:43:30 +0800
Message-Id: <20260805004330.1712178-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b0c53f03-6386-4d36-b7dc-28df02ce71b4@kernel.dk>
References: <20260730024050.1062354-1-yangxiuwei@kylinos.cn> <178581121634.578215.15829017092257405641.b4-ty@b4> <20260804063201.3740465-1-yangxiuwei@kylinos.cn> <b0c53f03-6386-4d36-b7dc-28df02ce71b4@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA34ewzh3JqJqQfMQ--.61178S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUeuWLUUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6RQmtmpyhzS+xwAA3-

Hi Jens,

On Tue, Aug 04, 2026 at 07:00:15AM -0600, Jens Axboe wrote:
> It's because your postings end up being broken, I had to explicitly grab
> 1/2 of this series too (which is why the reply looks odd.
>
> Added manually now.

Thanks for the explanation and for picking up 2/2. I'll keep the
selftest in the same series next time.

Thanks,
Yang Xiuwei

