Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C1FC3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E1420838
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583243390;
	bh=3GkkYYOhjilByBKM7RFVLaFFg+hkdhng4kDg5fw0tfg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Qw+cMzNDOsjeNvpt3WEUcrrvpAYNtU133X54ETknx77Uq+G3pZpkUIp7UpKQceKxl
	 seQs8U5cdZ1q4CiG2Wr6rvClpDk5Vo1yKvqs2TWY42xa9T3wlsiBdSb/tO/GVgZOyj
	 8xlDu4WLIpdQ2IE+ioCnWlFtrJ74vkvsL8Elv8iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgCCNtt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:49:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45566 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgCCNtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 08:49:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id z12so3346922qkg.12
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uz9ZkTp64z0X/ACJNPIEoKy0v9bgGueRFOMP31d3iZk=;
        b=N+UifCr4rbmpavWiDA1poWMPxqaD3t2YfrgA4142dJb/IWXdkO6adSu65bPfF1a6+n
         2Cul+eU8g53jFMJFCIxcwpM7oMN95IJLAlJS+Ug3ep0BeilA9bBDzJp6g/5IA3b3N4lm
         7I14NhaZjLcxzPUFUXmhEOdmW5BCiQHrz3H8o8iUZs6snnZvPT1Dd1nNhvrY2FL5u/Dd
         /BMoXYTIvjM8IGvlL5TUZ/RMdkyI7xhKYT897dNc0+qsOdpzRXxbQuUfa26PojWqF2J/
         UubReICSXtE6tTAbVc1TlqOapYalW4ATKTC5xvm1zlIrs89+SwFGC0TKc3YmJCnNoWj4
         X/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uz9ZkTp64z0X/ACJNPIEoKy0v9bgGueRFOMP31d3iZk=;
        b=FstMkvScKS4mvoxyUOx3QMz4I3icf+cn1unvC2nxfNCiC5qir9Nh1IiBs/GyxGl9xs
         H4oah1BQ0dRvZ4JNXpDndJGVkb47gArNXKXNku/5T/55PwtI2AzK+Ku8Pgx7swA4Nilf
         WzBJLvWlMD73r/GsAIKfVRkOsUc4QXRju6CB9XphS08BtHegZF7ma6noGzpI+XVTJfh9
         tSl5PrNszFTYCQcUcNV9pYPmLeIKCvhovg0CgD2EmqHU8w4BdMa7+yK9N5Qx0p1YR8qB
         x6FHV0CviwuT5sVhKUNEhu+zhm/Y4bNKM6ZoDL3J8MFIn+9gRKEOwDgMgL7ef24cZwQO
         XGWw==
X-Gm-Message-State: ANhLgQ034FG/pcV4KvHGmQmbfM2XR/GJ1NF6LBF28YNSFnhCJO65u90a
        3rZybWlSddt14lcZgdnTfWjDLnxKcdc=
X-Google-Smtp-Source: ADFU+vuIgPyvRVH6pASOPQ86TebTvFPVkz6VBzW5TSRzPaVX4JoGM1CnK+Bk/rN2WoQKCsWx7OYusA==
X-Received: by 2002:a05:620a:21c4:: with SMTP id h4mr4120561qka.382.1583243388544;
        Tue, 03 Mar 2020 05:49:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id z194sm12223042qkb.28.2020.03.03.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:49:47 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:49:47 -0500
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: remove duplicated lines in comments
Message-ID: <20200303134947.GB186184@mtj.thefacebook.com>
References: <20200227013845.GA14895@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227013845.GA14895@192.168.3.9>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 27, 2020 at 09:38:46AM +0800, Weiping Zhang wrote:
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
