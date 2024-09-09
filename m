Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27F1B81DD;
	Mon,  9 Sep 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887422; cv=none; b=WZVvlsV/Qkm04o0QwTVk0FOIFpXcrAvI3U0xPHP2m+nXsOJkxrSD5lzC3etQkzQDf/FPYtkmHXdTrUpANlsp6lwo3U8JMpd4XCxcnCPaqZYdpqet01wYrITlVLHgroXMo28PMmaaGz7Td7/q+NSGe+F4cPC2Zhbo7fiZOB7xJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887422; c=relaxed/simple;
	bh=nfr9RMJs2vOAJDAOpHKlVzZwA9+bJ41Qrp37yy6udxA=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=tJIkQmIHmHPkdCgK11LZ5v+xLSwDwxPu2i/XvWPU8Cv+Kfjf5klCoIk/XpB9U11A/BBUWajFrXiBPj4DfL6Qnb/7EDoyP94qYS0GNB579vLoiDTRuYzBFg+BLCK19huNe++fUT8A2WU1QSxiMsvbxJRCSw2326rTLupGNpjYCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X2Ry36GVqz1SB0y;
	Mon,  9 Sep 2024 21:09:47 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 57F2A14022D;
	Mon,  9 Sep 2024 21:10:15 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 21:10:14 +0800
Message-ID: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
Date: Mon, 9 Sep 2024 21:10:14 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-CA
To: <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
From: yangxingui <yangxingui@huawei.com>
Subject: [bug report] block: Non-NCQ commands will never be executed while fio
 is continuously running
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh200007.china.huawei.com (7.202.181.114) To
 kwepemg100017.china.huawei.com (7.202.181.58)

Hello axboe & John,

After the driver exposes all HW queues to the block layer, non-NCQ 
commands will never be executed while fio is continuously running, such 
as a smartctl command.

The cause of the problem is that other hctx used by the NCQ command is 
still active and can continue to issue NCQ commands to the sata disk.
And the pio command keeps retrying in its corresponding hctx because 
qc_defer() always returns true.

hctx0: ncq, pio, ncq
hctx1：ncq, ncq, ...
...
hctxn: ncq, ncq, ...

Is there any good solution for this?

Thanks.
Xingui
