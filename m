Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33451 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeEVXzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 19:55:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id e21-v6so3651746pgv.0
        for <linux-block@vger.kernel.org>; Tue, 22 May 2018 16:55:36 -0700 (PDT)
Date: Tue, 22 May 2018 16:55:34 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] blktests: use consistent helper returns
Message-ID: <20180522235534.GH9536@vader>
References: <20180522073611.4022-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522073611.4022-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 22, 2018 at 03:36:11AM -0400, Chaitanya Kulkarni wrote:
> This is a cleanup patch which uses consistent return values
> for helper functions.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thanks, applied.
