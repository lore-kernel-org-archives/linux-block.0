Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37092 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeJaCNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 22:13:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so5981185pgq.4
        for <linux-block@vger.kernel.org>; Tue, 30 Oct 2018 10:19:34 -0700 (PDT)
Message-ID: <1540919971.196084.113.camel@acm.org>
Subject: Re: [PATCH blktests -v2] Fix build failure for discontiguous-io on
 32-bit platforms
From: Bart Van Assche <bvanassche@acm.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-block@vger.kernel.org
Date: Tue, 30 Oct 2018 10:19:31 -0700
In-Reply-To: <20181030160223.GA6236@thunk.org>
References: <20181030143649.28246-1-tytso@mit.edu>
         <1540911775.196084.110.camel@acm.org> <20181030160223.GA6236@thunk.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-10-30 at 12:02 -0400, Theodore Y. Ts'o wrote:
+AD4 On Tue, Oct 30, 2018 at 08:02:55AM -0700, Bart Van Assche wrote:
+AD4 +AD4 Details about how the build fails on 32-bit systems would have been welcome
+AD4 +AD4 in the commit message. Anyway:
+AD4 +AD4 
+AD4 +AD4 Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 
+AD4 For the record, here's the failure.  It's the usual incomprehensible
+AD4 C+-+- error reporting.  :-)
+AD4 
+AD4 +AFs ... +AF0
+AD4 discontiguous-io.cpp: In function 'int main(int, char+ACoAKg)':
+AD4 discontiguous-io.cpp:294:34: error: no matching function for call to 'min(long unsigned int, size+AF8-t)'
+AD4          std::min(4ul, len - i +ACo 4))+ADs
+AD4                                   +AF4
+AD4 +AFs ... +AF0

Thanks Ted for having provided the full compiler output. However, I don't
think that the entire error message should go in the commit message. To me,
the part of the compiler error message I cited tells the whole story :-)

Bart.
