Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:33048 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdL1Dn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Dec 2017 22:43:58 -0500
Received: by mail-pl0-f50.google.com with SMTP id 1so19030048plv.0
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2017 19:43:58 -0800 (PST)
Subject: Re: [for-416 PATCH 1/3] bcache: writeback: collapse contiguous IO
 better
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1514431337-3528-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <21a24b1f-1aad-7983-9979-0985f1ee2e96@lyle.org>
Date: Wed, 27 Dec 2017 19:43:54 -0800
MIME-Version: 1.0
In-Reply-To: <1514431337-3528-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/27/2017 07:22 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> I remember I have reviewed this patch befor, still there is a bug
> in keys_contiguous(), since KEY_OFFSET(key) stores the end adress of the 
> request IO, so I think we should judge the contiguous of keys as bellow:
>     if (bkey_cmp(&first->key, &START_KEY(&second->key))
>         return false;
> Since bkey_cmp() also has judged the KEY_INODE(), so I think we can remove 
> the KEY_INODE() judement.
> 
> Acctually, we can totally use bkey_cmp to replace keys_contiguous().

This is a good point, thanks!  I'll fix & resend tomorrow.

Mike
