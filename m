Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34785 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbdC2SBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 14:01:33 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so5182287wrb.1
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2017 11:01:32 -0700 (PDT)
Subject: Re: [PATCH] block-mq: don't re-queue if we get a queue error
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <1490733472-3088-1-git-send-email-jbacik@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d02eedda-f2a7-4a73-8d42-044dc37e05d9@grimberg.me>
Date: Wed, 29 Mar 2017 21:01:28 +0300
MIME-Version: 1.0
In-Reply-To: <1490733472-3088-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
