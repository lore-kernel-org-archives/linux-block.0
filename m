Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36752 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdHRGvv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 02:51:51 -0400
Received: by mail-yw0-f182.google.com with SMTP id u207so53935271ywc.3
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2017 23:51:51 -0700 (PDT)
Date: Thu, 17 Aug 2017 23:51:47 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] loop: LOOP_FLAGS_BLOCKSIZE fixes
Message-ID: <20170818065147.GE2459@vader>
References: <cover.1503036471.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1503036471.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 17, 2017 at 11:15:24PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> A couple of bugs I found while adding blktests for the new loop block
> size feature. Based on v4.13-rc5, we should get these in for 4.13.

Just pushed the test: https://github.com/osandov/blktests/commit/7320725134cc0b65588bf03259201d74a0ee8226
