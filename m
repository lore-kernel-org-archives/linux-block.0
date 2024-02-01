Received: from server230-4.web-hosting.com (server230-4.web-hosting.com [198.54.116.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893379C6
	for <linux-block@vger.kernel.org>; Sat,  3 Feb 2024 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.116.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929415; cv=none; b=JQhZAyAyDHy9nYef6u+TVe9RVSBIXRkhnW32PNnRKM4BFlbTIbKboR7TzcSlsPFCxzq8lNeYRHMXuKqyty2NkxFcOmDekFyA0ou+qizmn7CaakC7sCgmwI1xEHA4hkGVHio6J53zSOpwOGhXpctUrWP/kZqig55UL6IQqGXCYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929415; c=relaxed/simple;
	bh=YvC/U1NkLv3ceYvS5h1VCcLG0d6XzDoqyraz7TQuY1w=;
	h=MIME-Version:Content-Type:Subject:From:To:Message-ID:Date; b=hNxTyOTf3Spe7L/P6OYKspo3NdWy9otWaPb2aIAxrRnJYlkRqygF0YSZDgxRheq6MRNfzgh303LIwU87B6FmDVdWH1oWpjZ8ZPQ0jwWny0TaXw1jUSxtr6EHGuPbNJgRAg1Hpt8EwmrwkcUPQ/A8EKiBxNMH94RJrf5D4EsQrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apyeth.live; spf=none smtp.mailfrom=server230.web-hosting.com; arc=none smtp.client-ip=198.54.116.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apyeth.live
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=server230.web-hosting.com
Received: from [127.0.0.1] (port=35298 helo=server230.web-hosting.com)
	by server230.web-hosting.com with esmtp (Exim 4.96.1)
	(envelope-from <mailman-bounces@server230.web-hosting.com>)
	id 1rW6JO-00GrrU-1l
	for linux-block@vger.kernel.org;
	Fri, 02 Feb 2024 22:03:26 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: apyeth.live mailing list memberships reminder
From: list1-owner@apyeth.live
To: linux-block@vger.kernel.org
X-No-Archive: yes
Auto-Submitted: auto-generated
Message-ID: <mailman.31496.1706781712.1933707.mailman@server230.web-hosting.com>
Date: Thu, 01 Feb 2024 05:01:52 -0500
Precedence: bulk
X-BeenThere: mailman@server230.web-hosting.com
X-Mailman-Version: 2.1.39
X-List-Administrivia: yes
Errors-To: mailman-bounces@server230.web-hosting.com
Sender: "Mailman" <mailman-bounces@server230.web-hosting.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server230.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - server230.web-hosting.com
X-Get-Message-Sender-Via: server230.web-hosting.com: acl_c_authenticated_local_user: mailman/mailman
X-Authenticated-Sender: server230.web-hosting.com: mailman@server230.web-hosting.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, sender is mailman

This is a reminder, sent out once a month, about your apyeth.live
mailing list memberships.  It includes your subscription info and how
to use it to change it or unsubscribe from a list.

You can visit the URLs to change your membership status or
configuration, including unsubscribing, setting digest-style delivery
or disabling delivery altogether (e.g., for a vacation), and so on.

In addition to the URL interfaces, you can also use email to make such
changes.  For more info, send a message to the '-request' address of
the list (for example, list1-request@apyeth.live) containing just the
word 'help' in the message body, and an email message will be sent to
you with instructions.

If you have questions, problems, comments, etc, send them to
list1-owner@apyeth.live.  Thanks!

Passwords for linux-block@vger.kernel.org:

List                                     Password // URL
----                                     --------  
list1@apyeth.live                        peivmeew  
http://apyeth.live/mailman/options/list1_apyeth.live/linux-block%40vger.kernel.org
