Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38444 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeJ3X4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 19:56:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id p7-v6so5687429plk.5
        for <linux-block@vger.kernel.org>; Tue, 30 Oct 2018 08:03:06 -0700 (PDT)
Message-ID: <1540911775.196084.110.camel@acm.org>
Subject: Re: [PATCH blktests -v2] Fix build failure for discontiguous-io on
 32-bit platforms
From: Bart Van Assche <bvanassche@acm.org>
To: Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org
Date: Tue, 30 Oct 2018 08:02:55 -0700
In-Reply-To: <20181030143649.28246-1-tytso@mit.edu>
References: <20181030143649.28246-1-tytso@mit.edu>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-10-30 at 10:36 -0400, Theodore Ts'o wrote:
+AD4 Signed-off-by: Theodore Ts'o +ADw-tytso+AEA-mit.edu+AD4
+AD4 ---
+AD4  src/discontiguous-io.cpp +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
+AD4 index 5e0ee0f..f51a305 100644
+AD4 --- a/src/discontiguous-io.cpp
+AD4 +-+-+- b/src/discontiguous-io.cpp
+AD4 +AEAAQA -251,7 +-251,7 +AEAAQA int main(int argc, char +ACoAKg-argv)
+AD4  	const char +ACo-dev+ADs
+AD4  	int c+ADs
+AD4  	std::vector+ADw-uint8+AF8-t+AD4 buf+ADs
+AD4 -	size+AF8-t len +AD0 512+ADs
+AD4 +-	unsigned long len +AD0 512+ADs
+AD4  
+AD4  	while ((c +AD0 getopt(argc, argv, +ACI-hl:o:sw+ACI)) +ACEAPQ EOF) +AHs
+AD4  		switch (c) +AHs

Details about how the build fails on 32-bit systems would have been welcome
in the commit message. Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
