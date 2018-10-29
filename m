Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38848 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJ3BQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 21:16:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so4152073pgq.5
        for <linux-block@vger.kernel.org>; Mon, 29 Oct 2018 09:27:10 -0700 (PDT)
Message-ID: <1540830403.196084.50.camel@acm.org>
Subject: Re: [PATCH blktests] Fix build failure for discontiguous-io on
 32-bit platforms
From: Bart Van Assche <bvanassche@acm.org>
To: Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org
Date: Mon, 29 Oct 2018 09:26:43 -0700
In-Reply-To: <20181029161534.7564-1-tytso@mit.edu>
References: <20181029161534.7564-1-tytso@mit.edu>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2018-10-29 at 12:15 -0400, Theodore Ts'o wrote:
+AD4 Signed-off-by: Theodore Ts'o +ADw-tytso+AEA-mit.edu+AD4
+AD4 ---
+AD4  src/discontiguous-io.cpp +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
+AD4 index 5e0ee0f..a59c18d 100644
+AD4 --- a/src/discontiguous-io.cpp
+AD4 +-+-+- b/src/discontiguous-io.cpp
+AD4 +AEAAQA -291,7 +-291,7 +AEAAQA int main(int argc, char +ACoAKg-argv)
+AD4  			unsigned char +ACo-p +AD0 +ACYAKg-buf.begin()+ADs
+AD4  			for (int i +AD0 0+ADs i +ADw len / 4+ADs i+-+-)
+AD4  				iov.append(p +- 4 +- i +ACo 8,
+AD4 -					   std::min(4ul, len - i +ACo 4))+ADs
+AD4 +-					   std::min(4ul, (unsigned long) len - i +ACo 4))+ADs
+AD4  		+AH0 else +AHs
+AD4  			iov.append(+ACYAKg-buf.begin(), buf.size())+ADs
+AD4  		+AH0

Hi Ted,

Have you considered to change the data type of 'len' from size+AF8-t into unsigned long
instead of inserting this cast? That would make it clear that no integer truncation
happens in the iov.append() call.

Thanks,

Bart.
