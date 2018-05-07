Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:5545 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751831AbeEGCa6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 May 2018 22:30:58 -0400
From: Caizhiyong <caizhiyong@hisilicon.com>
To: Wang YanQing <udknight@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiangheng <jiangheng@hisilicon.com>
Subject: RE: [PATCH v3] block: add verifier for cmdline partition
Date: Mon, 7 May 2018 02:30:47 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F8B7720E8@dggemm511-mbs.china.huawei.com>
References: <20180506052356.GA11163@udknight>
In-Reply-To: <20180506052356.GA11163@udknight>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>  /*
>   * Purpose: allocate cmdline partitions.
>   * Returns:
> @@ -93,6 +158,7 @@ int cmdline_partition(struct parsed_partitions *state)
>  	disk_size = get_capacity(state->bdev->bd_disk) << 9;
> 
>  	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
> +	cmdline_parts_verifier(1, (void *)state);

cmdline_parts_verifier(1, state); 

> 
>  	strlcat(state->pp_buf, "\n", PAGE_SIZE);
> 
> --
> 1.8.5.6.2.g3d8a54e.dirty
