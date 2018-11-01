Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37685 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeKAX4K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Nov 2018 19:56:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so9142459pgq.4
        for <linux-block@vger.kernel.org>; Thu, 01 Nov 2018 07:52:52 -0700 (PDT)
Message-ID: <1541083968.196084.140.camel@acm.org>
Subject: Re: [PATCH blktests] fix discontiguous-io compile error on 32 bit
 systems
From: Bart Van Assche <bvanassche@acm.org>
To: Yufen Yu <yuyufen@huawei.com>, osandov@fb.com
Cc: linux-block@vger.kernel.org, bart.vanassche@wdc.com,
        Theodore Ts'o <tytso@mit.edu>
Date: Thu, 01 Nov 2018 07:52:48 -0700
In-Reply-To: <1541054148-144718-1-git-send-email-yuyufen@huawei.com>
References: <1541054148-144718-1-git-send-email-yuyufen@huawei.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2018-11-01 at 14:35 +-0800, Yufen Yu wrote:
+AD4 When make discontiguous-io.cpp with -m32, g+-+- compiler reports
+AD4 error for std::min(long unsigned int, size+AF8-t) has diffent
+AD4 arguments type.
+AD4 
+AD4 fixes: fd21728886e7 (+ACI-Add the discontiguous-io test program+ACI)
+AD4 Signed-off-by: Yufen Yu +ADw-yuyufen+AEA-huawei.com+AD4
+AD4 ---
+AD4  src/discontiguous-io.cpp +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
+AD4 index 5e0ee0f..855aba9 100644
+AD4 --- a/src/discontiguous-io.cpp
+AD4 +-+-+- b/src/discontiguous-io.cpp
+AD4 +AEAAQA -291,7 +-291,7 +AEAAQA int main(int argc, char +ACoAKg-argv)
+AD4  			unsigned char +ACo-p +AD0 +ACYAKg-buf.begin()+ADs
+AD4  			for (int i +AD0 0+ADs i +ADw len / 4+ADs i+-+-)
+AD4  				iov.append(p +- 4 +- i +ACo 8,
+AD4 -					   std::min(4ul, len - i +ACo 4))+ADs
+AD4 +-					   std::min((size+AF8-t)4, len - i +ACo 4))+ADs
+AD4  		+AH0 else +AHs
+AD4  			iov.append(+ACYAKg-buf.begin(), buf.size())+ADs
+AD4  		+AH0

Are you reading the messages posted on linux-block? An alternative that I like
better has been discussed in this e-mail thread:
https://www.spinics.net/lists/linux-block/msg32181.html

Bart.
